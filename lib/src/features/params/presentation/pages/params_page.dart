import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../configs/injector/injector_conf.dart';
import '../../../../core/blocs/theme/theme_bloc.dart';
import '../../../../core/blocs/translate/translate_bloc.dart';
import '../../../../core/constants/list_translation_locale.dart';
import '../../../../routes/app_route_path.dart';
import '../../../../widgets/dialog_widget.dart';
import '../../../../widgets/button_widget.dart';
import '../../../../widgets/leading_back_button_widget.dart';
import '../../../../widgets/loading_widget.dart';
import '../../../../widgets/snackbar_widget.dart';
import '../../../auth/domain/entities/user_entity.dart';
import '../../../auth/presentation/bloc/auth/auth_bloc.dart';
import '../../../product/presentation/bloc/product/product_bloc.dart';

class ParamsPage extends StatefulWidget {
  final UserEntity user;

  const ParamsPage({super.key, required this.user});

  @override
  _ParamsPageState createState() => _ParamsPageState();
}

class _ParamsPageState extends State<ParamsPage> {
  late ProductBloc _productBloc;

  @override
  void initState() {
    _productBloc = getIt<ProductBloc>()..add(GetProductListEvent());
    super.initState();
  }

  void _logout(BuildContext context) {
    showDialog<bool>(
      barrierDismissible: false,
      context: context,
      builder: (_) => AppDialog(title: "exit_message".tr()),
    ).then(
      (value) => value ?? false
          ? context.read<AuthBloc>().add(AuthLogoutEvent())
          : null,
    );
  }

  void _changeTheme(BuildContext context) {
    final themeBloc = context.read<ThemeBloc>();
    if (themeBloc.state.isDarkMode) {
      themeBloc.add(LightThemeEvent());
    } else {
      themeBloc.add(DarkThemeEvent());
    }
  }

  void _changeLanguage(BuildContext context, String languageCode) {
    final trBloc = context.read<TranslateBloc>();
    if (languageCode == "fr") {
      context.setLocale(englishLocale);
      trBloc.add(TrEnglishEvent());
    } else {
      context.setLocale(frenchLocale);
      trBloc.add(TrFrenchEvent());
    }
    _productBloc.add(GetProductListEvent());
  }

  Widget _buildRow(BuildContext context, String label, Widget action) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.tr(),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
        ),
        SizedBox(height: 4.h),
        DefaultTextStyle(
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
              ),
          child: action,
        ),
        const Divider(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentLanguageCode = context.locale.languageCode;
    final targetLanguageCode = currentLanguageCode == "fr" ? "en" : "fr";
    final targetLanguageLabel = targetLanguageCode == "fr" ? "Français" : "English";

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => _productBloc,
        ),
        BlocProvider(
          create: (_) => getIt<AuthBloc>(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("params".tr()),
          leading: const AppBackButton(),
        ),
        body: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLogoutLoadingState) {
              showDialog(
                context: context,
                builder: (_) => const AppLoadingWidget(),
              );
            } else if (state is AuthLogoutSuccessState) {
              context.goNamed(AppRoute.login.name);
              appSnackBar(context, Colors.green, state.message);
            } else if (state is AuthLogoutFailureState) {
              context.pop();
              appSnackBar(context, Colors.red, state.message);
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  _buildRow(context, "username", Text(widget.user.username ?? "")),
                  _buildRow(context, "email", Text(widget.user.email ?? "")),
                  _buildRow(
                    context,
                    "change_theme",
                    AppButtonWidget(
                      label: context.read<ThemeBloc>().state.isDarkMode ? "light_mode".tr() : "dark_mode".tr(),
                      callback: () {
                        _changeTheme(context);
                      },
                      buttonType: ButtonType.text,
                      paddingHorizontal: 10.w,
                      paddingVertical: 0.h,
                      icon: Icon(
                        context.read<ThemeBloc>().state.isDarkMode
                            ? Icons.light_mode_rounded
                            : Icons.dark_mode_rounded,
                      ),
                    ),
                  ),
                  _buildRow(
                    context,
                    "change_language",
                    AppButtonWidget(
                      label: targetLanguageLabel,
                      callback: () {
                        _changeLanguage(context, currentLanguageCode);
                      },
                      buttonType: ButtonType.text,
                      paddingHorizontal: 10.w,
                      paddingVertical: 0.h,
                      icon: const Icon(Icons.language),
                    ),
                  ),
                  _buildRow(
                    context,
                    "logout",
                    AppButtonWidget(
                      label: "logout".tr(),
                      callback: () {
                        _logout(context);
                      },
                      buttonType: ButtonType.text,
                      paddingHorizontal: 10.w,
                      paddingVertical: 0.h,
                      icon: const Icon(Icons.logout),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
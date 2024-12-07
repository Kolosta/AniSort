import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../configs/injector/injector_conf.dart';
import '../../../../core/blocs/theme/theme_bloc.dart';
import '../../../../core/blocs/translate/translate_bloc.dart';
import '../../../../core/constants/list_translation_locale.dart';
import '../../../../routes/app_route_path.dart';
import '../../../../widgets/dialog_widget.dart';
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
  late ProductBloc _productBloc; //TODO : suprimer le ProductBloc, il est pas utilisé dans les params

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

  Widget _buildRow(BuildContext context, String label, String value, VoidCallback onPressed, IconData icon, String buttonText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0), // Add horizontal margins
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label.tr(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    value,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                  ),
                ],
              ),
              buttonText.isEmpty
                  ? IconButton(
                      onPressed: onPressed,
                      icon: Icon(icon),
                    )
                  : TextButton(
                      onPressed: onPressed,
                      child: Row(
                        children: [
                          Text(buttonText),
                          const SizedBox(width: 10),
                          Icon(icon),
                        ],
                      ),
                    ),
            ],
          ),
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
                  _buildRow(context, "username", widget.user.username ?? "", () {}, Icons.person, ""),
                  _buildRow(context, "email", widget.user.email ?? "", () {}, Icons.email, ""),
                  _buildRow(
                    context,
                    "theme".tr(),
                    context.read<ThemeBloc>().state.isDarkMode ? "dark_mode".tr() : "light_mode".tr(),
                    () {
                      _changeTheme(context);
                    },
                    context.read<ThemeBloc>().state.isDarkMode ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
                    "change".tr(),
                  ),
                  _buildRow(
                    context,
                    "language".tr(),
                    targetLanguageLabel,
                    () {
                      _changeLanguage(context, currentLanguageCode);
                    },
                    Icons.language,
                    "change".tr(),
                  ),
                  _buildRow(
                    context,
                    "logout".tr(),
                    "",
                    () {
                      _logout(context);
                    },
                    Icons.logout,
                    "logout".tr(),
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
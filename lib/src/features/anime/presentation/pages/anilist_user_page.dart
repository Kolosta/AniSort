import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:anilist_flutter/src/core/extensions/string_extension.dart';

import '../../../../configs/injector/injector_conf.dart';
import '../../../../widgets/leading_back_button_widget.dart';
import '../../data/models/models.dart';
import '../bloc/anilist_user/anilist_user_bloc.dart';

class AnilistUserPage extends StatelessWidget {
  final String username;

  const AnilistUserPage({super.key, required this.username});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AnilistUserBloc>()..add(GetAnilistUserEvent(username)),
      child: Scaffold(
        appBar: AppBar(
          title: Text('anilist_user_info'.tr()),
          leading: const AppBackButton(),
        ),
        body: BlocBuilder<AnilistUserBloc, AnilistUserState>(
          builder: (context, state) {
            if (state is AnilistUserLoadingState) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is AnilistUserFailureState) {
              return Center(child: Text(state.message));
            } else if (state is AnilistUserSuccessState) {
              final user = state.user;
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(user.avatar ?? 'assets/images/oeuf_a_la_loupe.png'),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          user.name ?? 'N/A',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        _buildRichText(user.about ?? 'no_description'.tr(), context),
                        const SizedBox(height: 16),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.score),
                          title: Text('score_format'.tr()),
                          subtitle: Text((user as AnilistUserModel).getScoreFormatText()),
                        ),
                        ListTile(
                          leading: const Icon(Icons.view_list),
                          title: Text('row_order'.tr()),
                          subtitle: Text(user.rowOrder?.capitalize() ?? 'unknown'.tr()),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  Widget _buildRichText(String about, BuildContext context) {
    final spans = <InlineSpan>[];

    final regex = RegExp(
      r'(~~.*?~~)|(_.*?_)|(~!.*?!~)|(__.*?__)|(img\d+\(.*?\))|(https?://[^\s]+)',
      multiLine: true,
    );

    final matches = regex.allMatches(about);
    int lastMatchEnd = 0;

    for (final match in matches) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(text: about.substring(lastMatchEnd, match.start)));
      }

      final matchText = match.group(0)!;
      if (matchText.startsWith('~~')) {
        spans.add(TextSpan(
          text: matchText.substring(2, matchText.length - 2),
          style: const TextStyle(decoration: TextDecoration.lineThrough),
        ));
      } else if (matchText.startsWith('_')) {
        spans.add(TextSpan(
          text: matchText.substring(1, matchText.length - 1),
          style: const TextStyle(fontStyle: FontStyle.italic),
        ));
      } else if (matchText.startsWith('~!')) {
        spans.add(TextSpan(
          text: matchText.substring(2, matchText.length - 2),
          style: const TextStyle(backgroundColor: Colors.black, color: Colors.black),
        ));
      } else if (matchText.startsWith('__')) {
        spans.add(TextSpan(
          text: matchText.substring(2, matchText.length - 2),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ));
      } else if (matchText.startsWith('img')) {
        final url = RegExp(r'\((.*?)\)').firstMatch(matchText)!.group(1)!;
        spans.add(WidgetSpan(
          child: Image.network(url, width: 100, height: 100),
        ));
      } else if (matchText.startsWith('http')) {
        spans.add(TextSpan(
          text: matchText,
          style: const TextStyle(color: Colors.blue),
          recognizer: TapGestureRecognizer()..onTap = () => launchUrl(Uri.parse(matchText)),
        ));
      }

      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < about.length) {
      spans.add(TextSpan(text: about.substring(lastMatchEnd)));
    }

    return RichText(
      text: TextSpan(style: Theme.of(context).textTheme.bodyMedium, children: spans),
    );
  }
}
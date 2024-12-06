import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive/hive.dart';

import '../../../../configs/injector/injector_conf.dart';
import '../../../../core/utils/logger.dart';
import '../../data/models/anime_model.dart';
import '../bloc/anime/anime_list_bloc.dart';
import '../widgets/anime_tile.dart';
import '../../../../core/themes/app_color.dart';
import '../../../../core/themes/app_font.dart';
import '../../../../core/blocs/theme/theme_bloc.dart';
import '../widgets/expandable_floatting_button.dart';

class AnimeListPage extends StatefulWidget {
  final String username;
  final String type;
  final List<String> status;

  const AnimeListPage({
    super.key,
    required this.username,
    required this.type,
    required this.status,
  });

  @override
  _AnimeListPageState createState() => _AnimeListPageState();
}

class _AnimeListPageState extends State<AnimeListPage> {
  late AnimeListBloc _animeListBloc;
  List<AnimeModel> _cacheData = [];

  @override
  void initState() {
    super.initState();
    _animeListBloc = getIt<AnimeListBloc>();
    _animeListBloc.add(GetLocalAnimeListEvent());
  }

  Future<void> _clearCache() async {
    const String boxName = 'cache';
    if (Hive.isBoxOpen(boxName)) {
      final box = Hive.box(boxName);
      await box.delete('animeList');
    } else {
      final box = await Hive.openBox(boxName);
      await box.delete('animeList');
      await box.close();
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Cache cleared successfully')),
    );
    _animeListBloc.add(GetLocalAnimeListEvent());
  }

  Future<void> _showCacheData() async {
    _animeListBloc.add(GetLocalAnimeListEvent());
  }

  Future<void> _uploadCacheData() async {
    logger.d('Cache Data: $_cacheData');
    _animeListBloc.add(UploadAnimeListToFirebaseEvent());
  }


  @override
  Widget build(BuildContext context) {
    final themeBloc = context.read<ThemeBloc>();
    final isDarkMode = themeBloc.state.isDarkMode;

    return BlocProvider(
      create: (_) => _animeListBloc,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BlocBuilder<AnimeListBloc, AnimeListState>(
                builder: (context, state) {
                  if (state is AnimeListLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AnimeListFailureState) {
                    return Center(child: Text(state.message));
                  } else if (state is AnimeListSuccessState) {
                    _cacheData = state.animeList
                        .map((anime) => AnimeModel.fromEntity(anime))
                        .toList();
                    if (_cacheData.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text(
                            'No anime in cache'.tr(),
                            style: AppFont.regular.copyWith(
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                        ),
                      );
                    } else {
                      return ListView.builder(
                        itemCount: _cacheData.length,
                        itemBuilder: (context, index) {
                          final anime = _cacheData[index];
                          return AnimeTile(anime: anime, isFromCache: true);
                        },
                      );
                    }
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
        floatingActionButton: ExpandableFloatingButton(
          actions: [
            ExpandableAction(
              icon: Icons.import_export,
              label: 'Import',
              onTap: () {
                _animeListBloc.add(ImportAnimeListFromAPIEvent(
                  username: widget.username,
                  type: widget.type,
                  status: widget.status,
                ));
              },
            ),
            ExpandableAction(
              icon: Icons.clear,
              label: 'Clear Cache',
              onTap: _clearCache,
            ),
            ExpandableAction(
              icon: Icons.visibility,
              label: 'Show Cache',
              onTap: _showCacheData,
            ),
            ExpandableAction(
              icon: Icons.upload,
              label: 'Upload',
              onTap: _uploadCacheData,
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildActionButton(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
    final themeBloc = context.read<ThemeBloc>();
    final isDarkMode = themeBloc.state.isDarkMode;

    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: isDarkMode ? Colors.white : Colors.black,
          ),
          Text(
            label,
            style: AppFont.regular.copyWith(
              color: isDarkMode ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
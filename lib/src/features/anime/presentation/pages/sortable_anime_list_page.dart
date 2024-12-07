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

class SortableAnimeListPage extends StatefulWidget {
  final String username;
  final String type;
  final List<String> status;

  const SortableAnimeListPage({
    super.key,
    required this.username,
    required this.type,
    required this.status,
  });

  @override
  _SortableAnimeListPage createState() => _SortableAnimeListPage();
}

class _SortableAnimeListPage extends State<SortableAnimeListPage> {
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

  void _updateAnimeList(int oldIndex, int newIndex) {
    setState(() {
      if (oldIndex < newIndex) {
        newIndex -= 1;
      }
      final AnimeModel anime = _cacheData.removeAt(oldIndex);
      _cacheData.insert(newIndex, anime);
    });
    _animeListBloc.add(UpdateAnimeListEvent(_cacheData.map((anime) => anime.toEntity()).toList()));
  }

  @override
  Widget build(BuildContext context) {

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
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      );
                    } else {
                      return ReorderableListView(
                        padding: const EdgeInsets.all(10),
                        onReorder: _updateAnimeList,
                        children: [
                          for (final anime in _cacheData)
                            Padding(
                              key: ObjectKey(anime), //ValueKey(anime.id) ne gère pas le cas où on a récupéré deux fois le même anime
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                color: Colors.grey[200],
                                child: AnimeTile(anime: anime, isFromCache: true),
                              ),
                            ),
                        ],
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
            ExpandableAction( //Import anime list from API
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
            ExpandableAction( // Clear anime list cache
              icon: Icons.clear,
              label: 'Clear Cache',
              onTap: _clearCache,
            ),
            ExpandableAction( // Show anime list from cache
              icon: Icons.visibility,
              label: 'Show Cache',
              onTap: _showCacheData,
            ),
            ExpandableAction( // Upload anime list to Firebase
              icon: Icons.upload,
              label: 'Upload',
              onTap: _uploadCacheData,
            ),
            ExpandableAction( // Validate anime order in cache
              icon: Icons.check,
              label: 'Validate Order',
              onTap: () {
                _animeListBloc.add(ValidateAnimeOrderEvent(_cacheData));
              },
            ),
          ],
        ),
      ),
    );
  }
}
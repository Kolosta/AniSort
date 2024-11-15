import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:hive/hive.dart';

import '../../../../configs/injector/injector_conf.dart';
import '../../data/models/anime_model.dart';
import '../bloc/anime/anime_list_bloc.dart';
import '../widgets/anime_tile.dart';

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
    _animeListBloc = getIt<AnimeListBloc>();
    super.initState();
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
  }

  Future<void> _showCacheData() async {
    const String boxName = 'cache';
    if (Hive.isBoxOpen(boxName)) {
      final box = Hive.box(boxName);
      final data = box.get('animeList');
      setState(() {
        _cacheData = (data as List).map((e) => AnimeModel.fromMap(Map<String, dynamic>.from(e))).toList();
      });
    } else {
      final box = await Hive.openBox(boxName);
      final data = box.get('animeList');
      setState(() {
        _cacheData = (data as List).map((e) => AnimeModel.fromMap(Map<String, dynamic>.from(e))).toList();
      });
      await box.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _animeListBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Text('anime_list'.tr()),
        ),
        body: Column(
          children: [
            Center(
              child: ElevatedButton(
                onPressed: () {
                  _animeListBloc.add(GetAnimeListEvent(
                    username: widget.username,
                    type: widget.type,
                    status: widget.status,
                  ));
                },
                child: const Text('Get from Anilist API'),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: _clearCache,
                child: const Text('Clear Cache'),
              ),
            ),
            Center(
              child: ElevatedButton(
                onPressed: _showCacheData,
                child: const Text('Show Cache Data'),
              ),
            ),
            Expanded(
              child: BlocBuilder<AnimeListBloc, AnimeListState>(
                builder: (context, state) {
                  if (state is AnimeListLoadingState) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is AnimeListFailureState) {
                    return Center(child: Text(state.message));
                  } else if (state is AnimeListSuccessState) {
                    return ListView.builder(
                      itemCount: state.animeList.length,
                      itemBuilder: (context, index) {
                        final anime = state.animeList[index];
                        return AnimeTile(anime: anime);
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
            if (_cacheData.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _cacheData.length,
                  itemBuilder: (context, index) {
                    final anime = _cacheData[index];
                    return AnimeTile(anime: anime, isFromCache: true);
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
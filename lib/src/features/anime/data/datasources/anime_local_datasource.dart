import 'package:anilist_flutter/src/core/errors/exceptions.dart';
import 'package:anilist_flutter/src/features/anime/data/models/anime_model.dart';

import '../../../../configs/injector/injector.dart';
import '../../../../core/utils/logger.dart';

abstract class AnimeLocalDataSource {
  Future<void> saveAnimeList(List<AnimeModel> animeList);
}

class AnimeLocalDataSourceImpl implements AnimeLocalDataSource {
  final HiveLocalStorage _localStorage;

  const AnimeLocalDataSourceImpl(this._localStorage);

  @override
  Future<void> saveAnimeList(List<AnimeModel> animeList) async {
    try {
      // logger.d('saveAnimeList called with: $animeList');

      // Charger la liste des animes existants depuis le cache
      final existingAnimeList = (await _localStorage.load(
          key: 'animeList',
          boxName: 'cache'
      )) as List<dynamic>? ?? [];

      // logger.d('COUCOU TOI 0');
      // logger.d('COUCOU TOI 0V2 $existingAnimeList');
      // logger.d("COUCOU TOI 0V3 ${existingAnimeList.cast<Map<String, dynamic>>()}");
      // final animeModelList = existingAnimeList.map((e) => AnimeModel.fromMap(Map<String, dynamic>.from(e as Map))).toList();
      final animeModelList = AnimeModel.fromMapList(existingAnimeList.cast<Map<String, dynamic>>());
      // logger.d('COUCOU TOI 1');
      final updatedAnimeList = <AnimeModel>[];
      // logger.d('COUCOU TOI 2');

      for (final anime in animeList) {
        // logger.d('COUCOU TOI 3');
        final existingAnime = animeModelList.firstWhere(
              (a) => a.title == anime.title,
          orElse: () => anime,
        );
        updatedAnimeList.add(existingAnime.copyWith(
          username: anime.username,
          type: anime.type,
          format: anime.format,
          status: anime.status,
          episodes: anime.episodes,
          duration: anime.duration,
          source: anime.source,
          studios: anime.studios,
          genres: anime.genres,
          popularity: anime.popularity,
          synonyms: anime.synonyms,
          bannerImage: anime.bannerImage,
          coverImage: anime.coverImage,
          season: anime.season,
          seasonYear: anime.seasonYear,
          score: anime.score,
          progress: anime.progress,
          repeat: anime.repeat,
          notes: anime.notes,
          startedAt: anime.startedAt,
          completedAt: anime.completedAt,
          updatedAt: anime.updatedAt,
        ));
      }

      // logger.d('COUCOU TOI 4');
      updatedAnimeList.sort((a, b) => a.compareTo(b));
      for (var i = 0; i < updatedAnimeList.length; i++) {
        updatedAnimeList[i] = updatedAnimeList[i].copyWith(localScore: i);
      }

      // logger.i('updatedAnimeList: $updatedAnimeList');
      // logger.i("updatedAnimeList: ${AnimeModel.toMapList(updatedAnimeList)}");

      // logger.d('COUCOU TOI 4');
      await _localStorage.save(
          key: 'animeList',
          value: AnimeModel.toMapList(updatedAnimeList),
          boxName: 'cache'
      );

      // logger.d('COUCOU TOI 6');
      // logger.d('saveAnimeList successfully saved: $updatedAnimeList');
    } catch (e) {
      logger.e('Error in saveAnimeList: $e');
      throw CacheException('Failed to save anime list: ${e.toString()}');
    }
  }
}
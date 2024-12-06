import 'package:fpdart/fpdart.dart';

import '../../../../core/cache/local_storage.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_checker.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/utils/logger.dart';
import '../../domain/entities/anime_entity.dart';
import '../../domain/repositories/anime_repository.dart';
import '../datasources/anime_local_datasource.dart';
import '../datasources/anime_remote_datasource.dart';
import '../models/models.dart';

class AnimeRepositoryImpl implements AnimeRepository {
  final AnimeRemoteDataSource _remoteDataSource;
  final AnimeLocalDataSource _localDataSource;
  final LocalStorage _localStorage;
  // final NetworkInfo _networkInfo;

  const AnimeRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    this._localStorage,
    // this._networkInfo,
  );

  @override
  Future<Either<Failure, List<AnimeEntity>>> getAnimeListFromApi(String username, String type, List<String> status) async {
    try {
      final remoteAnimeList = await _remoteDataSource.fetchAnimeList(username, type, status);
      return Right(remoteAnimeList);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<AnimeEntity>>> importAnimeListFromAPI(String username, String type, List<String> status) async {
    try {
      final remoteAnimeList = await _remoteDataSource.fetchAnimeList(username, type, status);
      final localAnimeEntityList = await _localDataSource.getLocalAnimeList();
      //await _localDataSource.saveLocalAnimeList(remoteAnimeList); //OLD

      //Charger uniquement les modifications de la liste d'animes dans le cache.
      final updatedAnimeList = <AnimeModel>[];

      //Ajouter les animes locaux qui ne sont pas dans la liste distante
      for (final anime in remoteAnimeList) {
        //Chercher l'anime local correspondant à l'anime distant
        final existingAnime = localAnimeEntityList.firstWhere(
              (a) => a.title == anime.title,
          orElse: () => anime,
        );

        //Ajouter l'anime local à la liste des animes mis à jour
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
          coverImageExtraLarge: anime.coverImageExtraLarge,
          coverImageLarge: anime.coverImageLarge,
          coverImageMedium: anime.coverImageMedium,
          coverImageColor: anime.coverImageColor,
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

      //Tri de la liste des animes mis à jour
      updatedAnimeList.sort((a, b) => a.compareTo(b));

      //Ajouter un score local à chaque anime
      for (var i = 0; i < updatedAnimeList.length; i++) {
        updatedAnimeList[i] = updatedAnimeList[i].copyWith(localScore: i);
      }

      await _localStorage.save(
        key: "animeList",
        value: AnimeModel.toMapList(updatedAnimeList),
        boxName: "cache",
      );

      return Right(updatedAnimeList);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<AnimeEntity>>> getLocalAnimeList() async {
    try {
      final localAnimeList = await _localDataSource.getLocalAnimeList();
      return Right(localAnimeList);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> uploadAnimeListToFirebase() async {
    try {
      final localAnimeList = await _localDataSource.getLocalAnimeList();
      await _remoteDataSource.uploadAnimeList(localAnimeList);
      return const Right(null);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // @override
  // Future<Either<Failure, void>> uploadAnimeListToFirebase(List<AnimeModel> animeList) async {
  //   try {
  //     await _remoteDataSource.uploadAnimeList(animeList);
  //     return const Right(null);
  //   } on ServerException {
  //     return Left(ServerFailure());
  //   }
  // }

  // @override
  // Future<Either<Failure, List<AnimeEntity>>> importAnimeListFromAPI() async {
  //   try {
  //     final animeList = await _localDataSource.getAllAnime();
  //     if (animeList.isEmpty) {
  //       return Left(CacheFailure());
  //     }
  //     return Right(animeList);
  //   } on CacheException {
  //     return Left(CacheFailure());
  //   }
  // }

  // @override
  // Future<Either<Failure, List<AnimeEntity>>> refreshAnimeList() async {
  //   if (await _networkInfo.isConnected) {
  //     try {
  //       final remoteAnimeList = await _remoteDataSource.fetchAnimeList();
  //       final localAnimeList = await _localDataSource.getAllAnime();
  //
  //       final updatedAnimeList = remoteAnimeList.map((remoteAnime) {
  //         final localAnime = localAnimeList.firstWhere(
  //             (localAnime) => localAnime.id == remoteAnime.id,
  //             orElse: () => remoteAnime);
  //         return remoteAnime.copyWith(localScore: localAnime.localScore);
  //       }).toList();
  //
  //       await _localDataSource.saveAllAnime(updatedAnimeList);
  //       return Right(updatedAnimeList);
  //     } on ServerException {
  //       return Left(ServerFailure());
  //     }
  //   } else {
  //     return Left(NetworkFailure());
  //   }
  // }
  //
  // @override
  // Future<Either<Failure, void>> exportAnimeList() async {
  //   try {
  //     final animeList = await _localDataSource.getAllAnime();
  //     await _remoteDataSource.exportAnimeList(animeList);
  //     return const Right(null);
  //   } on ServerException {
  //     return Left(ServerFailure());
  //   }
  // }
  //
  // @override
  // Future<Either<Failure, List<AnimeEntity>>> importAnimeList() async {
  //   if (await _networkInfo.isConnected) {
  //     try {
  //       final remoteAnimeList = await _remoteDataSource.importAnimeList();
  //       await _localDataSource.saveAllAnime(remoteAnimeList);
  //       return Right(remoteAnimeList);
  //     } on ServerException {
  //       return Left(ServerFailure());
  //     }
  //   } else {
  //     return Left(NetworkFailure());
  //   }
  // }
}
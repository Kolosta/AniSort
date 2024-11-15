import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/network/network_checker.dart';
import '../../domain/repositories/anime_repository.dart';
import '../datasources/anime_local_datasource.dart';
import '../datasources/anime_remote_datasource.dart';
import '../models/models.dart';

class AnimeRepositoryImpl implements AnimeRepository {
  final AnimeRemoteDataSource _remoteDataSource;
  final AnimeLocalDataSource _localDataSource;
  // final NetworkInfo _networkInfo;

  const AnimeRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
    // this._networkInfo,
  );

  @override
  Future<Either<Failure, List<AnimeModel>>> getAnimeList(String username, String type, List<String> status) async {
    try {
      final remoteAnimeList = await _remoteDataSource.fetchAnimeList(username, type, status);
      await _localDataSource.saveAnimeList(remoteAnimeList);
      return Right(remoteAnimeList);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  // @override
  // Future<Either<Failure, List<AnimeModel>>> getAnimeList() async {
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
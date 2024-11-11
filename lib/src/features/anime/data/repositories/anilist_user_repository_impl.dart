import 'package:anilist_flutter/src/features/anime/data/datasources/anilist_user_remote_datasource.dart';
import 'package:anilist_flutter/src/features/anime/data/models/models.dart';
import 'package:anilist_flutter/src/features/anime/domain/repositories/anilist_user_repository.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/logger.dart';

class AnilistUserRepositoryImpl implements AnilistUserRepository {
  final AnilistUserRemoteDataSource _remoteDataSource;

  const AnilistUserRepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, AnilistUserModel>> getUser(String username) async {
    try {
      final user = await _remoteDataSource.fetchAnilistUser(username);
      return Right(user);

    } on TypeMismatchException catch (e) {
      return Left(TypeMismatchFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
import 'package:anilist_flutter/src/features/anime/data/models/models.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';

abstract class AnilistUserRepository {
  Future<Either<Failure, AnilistUserModel>> getUser(String username);
}
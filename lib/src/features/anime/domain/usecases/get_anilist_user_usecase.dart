import 'package:anilist_flutter/src/features/anime/domain/entities/anilist_user_entity.dart';
import 'package:anilist_flutter/src/features/anime/domain/repositories/anilist_user_repository.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';

class GetAnilistUserUseCase implements UseCase<AnilistUserEntity, Params> {
  final AnilistUserRepository _repository;

  const GetAnilistUserUseCase(this._repository);

  @override
  Future<Either<Failure, AnilistUserEntity>> call(Params params) async {
    return await _repository.getUser(params.username);
  }
}

class Params {
  final String username;

  const Params({required this.username});
}
import 'package:fpdart/fpdart.dart';
import 'package:anilist_flutter/src/core/errors/failures.dart';
import 'package:anilist_flutter/src/core/usecases/usecase.dart';
import 'package:anilist_flutter/src/features/anime/domain/entities/anime_entity.dart';
import 'package:anilist_flutter/src/features/anime/domain/repositories/anime_repository.dart';

class GetAnimeListFromApiUseCase implements UseCase<List<AnimeEntity>, GetApiParams> {
  final AnimeRepository _repository;

  const GetAnimeListFromApiUseCase(this._repository);

  @override
  Future<Either<Failure, List<AnimeEntity>>> call(GetApiParams params) async {
    return await _repository.getAnimeListFromApi(params.username, params.type, params.status);
  }
}

class GetApiParams {
  final String username;
  final String type;
  final List<String> status;

  const GetApiParams({
    required this.username,
    required this.type,
    required this.status
  });
}
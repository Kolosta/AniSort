import 'package:fpdart/fpdart.dart';
import 'package:anilist_flutter/src/core/errors/failures.dart';
import 'package:anilist_flutter/src/core/usecases/usecase.dart';
import 'package:anilist_flutter/src/features/anime/domain/entities/anime_entity.dart';
import 'package:anilist_flutter/src/features/anime/domain/repositories/anime_repository.dart';

class GetAnimeListUseCase implements UseCase<List<AnimeEntity>, Params> {
  final AnimeRepository _repository;

  const GetAnimeListUseCase(this._repository);

  @override
  Future<Either<Failure, List<AnimeEntity>>> call(Params params) async {
    return await _repository.getAnimeList(params.username, params.type, params.status);
  }
}

class Params {
  final String username;
  final String type;
  final List<String> status;

  const Params({
      required this.username,
      required this.type,
      required this.status
  });
}
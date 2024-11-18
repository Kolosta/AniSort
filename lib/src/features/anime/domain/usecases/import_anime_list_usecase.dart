import 'package:fpdart/fpdart.dart';
import 'package:anilist_flutter/src/core/errors/failures.dart';
import 'package:anilist_flutter/src/core/usecases/usecase.dart';
import 'package:anilist_flutter/src/features/anime/domain/entities/anime_entity.dart';
import 'package:anilist_flutter/src/features/anime/domain/repositories/anime_repository.dart';

class ImportAnimeListUseCase implements UseCase<List<AnimeEntity>, ImportParams> {
  final AnimeRepository _repository;

  const ImportAnimeListUseCase(this._repository);

  @override
  Future<Either<Failure, List<AnimeEntity>>> call(ImportParams params) async {
    return await _repository.importAnimeListFromAPI(params.username, params.type, params.status);
  }
}

class ImportParams {
  final String username;
  final String type;
  final List<String> status;

  const ImportParams({
      required this.username,
      required this.type,
      required this.status
  });
}
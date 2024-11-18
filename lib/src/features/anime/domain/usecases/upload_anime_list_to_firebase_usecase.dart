import 'package:fpdart/fpdart.dart';
import 'package:anilist_flutter/src/core/errors/failures.dart';
import 'package:anilist_flutter/src/core/usecases/usecase.dart';
import 'package:anilist_flutter/src/features/anime/domain/repositories/anime_repository.dart';

import '../entities/anime_entity.dart';

class UploadAnimeListToFirebaseUseCase implements UseCase<void, NoParams> {
  final AnimeRepository _repository;

  const UploadAnimeListToFirebaseUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) async {
    return await _repository.uploadAnimeListToFirebase();
  }
}
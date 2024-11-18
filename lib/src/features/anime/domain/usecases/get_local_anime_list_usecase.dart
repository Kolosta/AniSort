import 'package:fpdart/fpdart.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/anime_entity.dart';
import '../repositories/anime_repository.dart';

class GetLocalAnimeListUseCase implements UseCase<List<AnimeEntity>, NoParams> {
  final AnimeRepository _repository;

  const GetLocalAnimeListUseCase(this._repository);

  @override
  Future<Either<Failure, List<AnimeEntity>>> call(NoParams params) async {
    return await _repository.getLocalAnimeList();
  }
}
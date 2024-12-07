import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/anime_entity.dart';
import '../repositories/anime_repository.dart';

class ValidateAnimeOrderUseCase implements UseCase<void, List<AnimeEntity>> {
  final AnimeRepository _repository;

  const ValidateAnimeOrderUseCase(this._repository);

  @override
  Future<Either<Failure, void>> call(List<AnimeEntity> animeList) async {
    return await _repository.validateAnimeOrder(animeList);
  }
}
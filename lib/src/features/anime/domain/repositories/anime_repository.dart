import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';
import '../entities/anime_entity.dart';

abstract class AnimeRepository {
  Future<Either<Failure, List<AnimeEntity>>> importAnimeListFromAPI(String username, String type, List<String> status);
  Future<Either<Failure, List<AnimeEntity>>> getLocalAnimeList();
  Future<Either<Failure, List<AnimeEntity>>> getAnimeListFromApi(String username, String type, List<String> status);
  Future<Either<Failure, void>> uploadAnimeListToFirebase();
  Future<Either<Failure, void>> validateAnimeOrder(List<AnimeEntity> animeList);
}
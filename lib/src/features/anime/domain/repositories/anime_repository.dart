import 'package:anilist_flutter/src/features/anime/data/models/models.dart';
import 'package:fpdart/fpdart.dart';
import '../../../../core/errors/failures.dart';

abstract class AnimeRepository {
  Future<Either<Failure, List<AnimeModel>>> getAnimeList(String username, String type, List<String> status);
  //Future<Either<Failure, List<AnimeModel>>> refreshAnimeList();
}
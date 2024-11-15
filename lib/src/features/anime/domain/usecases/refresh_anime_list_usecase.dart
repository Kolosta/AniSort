// import 'package:fpdart/fpdart.dart';
// import 'package:anilist_flutter/src/core/errors/failures.dart';
// import 'package:anilist_flutter/src/core/usecases/usecase.dart';
// import 'package:anilist_flutter/src/features/anime/domain/entities/anime_entity.dart';
// import 'package:anilist_flutter/src/features/anime/domain/repositories/anime_repository.dart';
//
// class RefreshAnimeListUseCase implements UseCase<List<AnimeEntity>, RefreshParams> {
//   final AnimeRepository _repository;
//
//   const RefreshAnimeListUseCase(this._repository);
//
//   @override
//   Future<Either<Failure, List<AnimeEntity>>> call(RefreshParams params) async {
//     return await _repository.refreshAnimeList(params.userId, params.type, params.status);
//   }
// }
//
// class RefreshParams {
//   final int userId;
//   final String type;
//   final List<String> status;
//
//   const RefreshParams({
//     required this.userId,
//     required this.type,
//     required this.status,
//   });
// }
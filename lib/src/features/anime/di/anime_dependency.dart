import 'package:anilist_flutter/src/features/anime/data/datasources/anime_remote_datasource.dart';
import 'package:anilist_flutter/src/features/anime/domain/usecases/get_anime_list_usecase.dart';
import 'package:anilist_flutter/src/features/anime/presentation/bloc/anime/anime_list_bloc.dart';

import '../../../configs/injector/injector.dart';
import '../../../configs/injector/injector_conf.dart';
import '../data/datasources/anime_local_datasource.dart';
import '../data/repositories/anime_repository_impl.dart';

class AnimeDependency {
  AnimeDependency._();

  static void init() {
    getIt.registerFactory(
      () => AnimeListBloc(
        getIt<GetAnimeListUseCase>()
      ),
    );

    getIt.registerLazySingleton(
      () => GetAnimeListUseCase(
        getIt<AnimeRepositoryImpl>()
      ),
    );

    getIt.registerLazySingleton(
      () => AnimeRepositoryImpl(
        getIt<AnimeRemoteDataSourceImpl>(),
        getIt<AnimeLocalDataSourceImpl>()
      ),
    );

    getIt.registerLazySingleton(
      () => AnimeRemoteDataSourceImpl(
        getIt<ApiHelper>(),
        getIt<AnimeLocalDataSourceImpl>()
      ),
    );

    getIt.registerLazySingleton(
      () => AnimeLocalDataSourceImpl(
        getIt<HiveLocalStorage>()
      ),
    );
  }
}
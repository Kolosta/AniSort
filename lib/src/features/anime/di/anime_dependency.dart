import 'package:anilist_flutter/src/features/anime/data/datasources/anime_remote_datasource.dart';
import 'package:anilist_flutter/src/features/anime/domain/usecases/import_anime_list_usecase.dart';
import 'package:anilist_flutter/src/features/anime/presentation/bloc/anime/anime_list_bloc.dart';

import '../../../configs/injector/injector.dart';
import '../../../configs/injector/injector_conf.dart';
import '../data/datasources/anime_local_datasource.dart';
import '../data/repositories/anime_repository_impl.dart';
import '../domain/usecases/get_anime_list_from_api_usecase.dart';
import '../domain/usecases/get_local_anime_list_usecase.dart';
import '../domain/usecases/upload_anime_list_to_firebase_usecase.dart';

class AnimeDependency {
  AnimeDependency._();

  static void init() {
    // Bloc
    getIt.registerFactory(
      () => AnimeListBloc(
        getIt<ImportAnimeListUseCase>(),
        getIt<GetLocalAnimeListUseCase>(),
        getIt<GetAnimeListFromApiUseCase>(),
        getIt<UploadAnimeListToFirebaseUseCase>(),
      ),
    );

    // Use Cases
    getIt.registerLazySingleton(
      () => ImportAnimeListUseCase(
        getIt<AnimeRepositoryImpl>()
      ),
    );
    getIt.registerLazySingleton(
      () => GetLocalAnimeListUseCase(
        getIt<AnimeRepositoryImpl>()
      ),
    );
    getIt.registerLazySingleton(
      () => GetAnimeListFromApiUseCase(
        getIt<AnimeRepositoryImpl>()
      ),
    );
    getIt.registerLazySingleton(
      () => UploadAnimeListToFirebaseUseCase(
        getIt<AnimeRepositoryImpl>()
      ),
    );

    // Repository
    getIt.registerLazySingleton(
      () => AnimeRepositoryImpl(
        getIt<AnimeRemoteDataSourceImpl>(),
        getIt<AnimeLocalDataSourceImpl>(),
        getIt<HiveLocalStorage>()
      ),
    );

    // Data Sources
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
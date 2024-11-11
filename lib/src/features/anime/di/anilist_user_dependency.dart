import '../../../configs/injector/injector_conf.dart';
import '../../../core/api/api_helper.dart';
import '../data/datasources/anilist_user_remote_datasource.dart';
import '../data/repositories/anilist_user_repository_impl.dart';
import '../domain/usecases/get_anilist_user_usecase.dart';
import '../presentation/bloc/anilist_user_bloc.dart';

class AnilistUserDependency {
  AnilistUserDependency._();

  static void init() {
    getIt.registerFactory(
      () => AnilistUserBloc(
          getIt<GetAnilistUserUseCase>()
      ),
    );

    getIt.registerLazySingleton(
      () => GetAnilistUserUseCase(
          getIt<AnilistUserRepositoryImpl>()
      ),
    );

    getIt.registerLazySingleton(
      () => AnilistUserRepositoryImpl(
          getIt<AnilistUserRemoteDataSourceImpl>()
      ),
    );

    getIt.registerLazySingleton(
      () => AnilistUserRemoteDataSourceImpl(
          getIt<ApiHelper>()
      ),
    );
  }
}
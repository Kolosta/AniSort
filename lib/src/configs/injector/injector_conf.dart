import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../core/api/api_helper.dart';
import '../../core/api/api_interceptor.dart';
import '../../core/blocs/theme/theme_bloc.dart';
import '../../core/blocs/translate/translate_bloc.dart';
import '../../core/cache/hive_local_storage.dart';
import '../../core/cache/secure_local_storage.dart';
import '../../core/network/network_checker.dart';
import '../../features/auth/di/auth_depedency.dart';
import '../../features/product/di/product_depedency.dart';
import '../../routes/app_route_conf.dart';
import 'injector.dart';

final getIt = GetIt.I;

void configureDepedencies() {
  AuthDepedency.init();
  ProductDependency.init();

  getIt.registerLazySingleton(
        () => ThemeBloc(),
  );

  getIt.registerLazySingleton(
        () => TranslateBloc(),
  );

  getIt.registerLazySingleton(
        () => AppRouteConf(),
  );

  getIt.registerLazySingleton(
        () => ApiHelper(
      getIt<Dio>(),
    ),
  );

  getIt.registerLazySingleton(
        () => Dio()
      ..interceptors.add(
        getIt<ApiInterceptor>(),
      ),
  );

  getIt.registerLazySingleton(
        () => ApiInterceptor(),
  );

  getIt.registerLazySingleton(
        () => SecureLocalStorage(
      getIt<FlutterSecureStorage>(),
    ),
  );

  getIt.registerLazySingleton(
        () => HiveLocalStorage(),
  );

  getIt.registerLazySingleton(
        () => NetworkInfo(
      getIt<InternetConnectionChecker>(),
    ),
  );

  getIt.registerLazySingleton(
        () => InternetConnectionChecker(),
  );

  getIt.registerLazySingleton(
        () => const FlutterSecureStorage(),
  );
}

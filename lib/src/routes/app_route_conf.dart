import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/anime/domain/entities/anime_list_params.dart';
import '../features/main/presentation/pages/main_page.dart';
import 'app_route_path.dart';
import 'routes.dart';

class AppRouteConf {
  GoRouter get router => _router;

  late final _router = GoRouter(
    initialLocation: AppRoute.auth.path,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoute.auth.path,
        name: AppRoute.auth.name,
        builder: (_, __) => const AuthPage(),
        routes: [
          GoRoute(
            path: AppRoute.login.path,
            name: AppRoute.login.name,
            builder: (_, __) => const LoginPage(),
          ),
          GoRoute(
            path: AppRoute.register.path,
            name: AppRoute.register.name,
            builder: (_, __) => const RegisterPage(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoute.home.path,
        name: AppRoute.home.name,
        builder: (_, state) {
          final params = state.pathParameters;
          final user = UserEntity(
            username: params["username"],
            email: params["email"],
            userId: params["user_id"],
          );

          return HomePage(user: user);
        },
      ),
      GoRoute(
        path: AppRoute.mainPage.path,
        name: AppRoute.mainPage.name,
        builder: (_, state) {
          final params = state.pathParameters;
          final user = UserEntity(
            username: params["username"],
            email: params["email"],
            userId: params["user_id"],
          );

          return MainPage(user: user);
        },
      ),
      GoRoute(
        path: AppRoute.createProduct.path,
        name: AppRoute.createProduct.name,
        builder: (_, state) {
          final context = state.extra as BuildContext;

          return CreateProductPage(ctx: context);
        },
      ),
      GoRoute(
        path: AppRoute.updateProduct.path,
        name: AppRoute.updateProduct.name,
        builder: (_, state) {
          final context = state.extra as BuildContext;
          final params = state.pathParameters;

          final product = UpdateProductParams(
            productId: params["product_id"] ?? "",
            name: params["product_name"] ?? "",
            price: int.tryParse(params["product_price"] ?? "") ?? 0,
          );

          return UpdateProductPage(
            ctx: context,
            productParams: product,
          );
        },
      ),
      GoRoute(
        path: AppRoute.params.path,
        name: AppRoute.params.name,
        builder: (_, state) {
          final params = state.pathParameters;
          final user = UserEntity(
            username: params["username"],
            email: params["email"],
            userId: params["user_id"],
          );

          return ParamsPage(user: user);
        },
      ),
      GoRoute(
        path: AppRoute.anilistUser.path,
        name: AppRoute.anilistUser.name,
        builder: (_, state) {
          final username = state.pathParameters['username'] ?? '';
          return AnilistUserPage(username: username);
        },
      ),
      // GoRoute(
      //   path: AppRoute.animeList.path,
      //   name: AppRoute.animeList.name,
      //   builder: (_, state) {
      //     final username = state.pathParameters['username'] ?? '';
      //     final type = state.pathParameters['type'] ?? '';
      //     final status = (state.pathParameters['status'] ?? '').split(',');
      //     return AnimeListPage(username: username, type: type, status: status);
      //   },
      // ),
      GoRoute(
        path: AppRoute.animeList.path,
        name: AppRoute.animeList.name,
        builder: (_, state) {
          final animeListParams = state.extra as AnimeListParams;
          return AnimeListPage(
            username: animeListParams.username,
            type: animeListParams.type,
            status: animeListParams.status,
          );
        },
      ),
    ],
  );
}
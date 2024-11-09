import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/domain/entities/user_entity.dart';
import '../features/auth/presentation/pages/auth_page.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/register_page.dart';
import '../features/params/presentation/pages/params_page.dart';
import '../features/product/domain/usecases/usecase_params.dart';
import '../features/product/presentation/pages/create_product_page.dart';
import '../features/product/presentation/pages/product_page.dart';
import '../features/product/presentation/pages/update_product_page.dart';
import 'app_route_path.dart';

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
    ],
  );
}
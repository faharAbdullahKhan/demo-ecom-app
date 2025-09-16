import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:demo_ecommerce/features/cart/routes/routes.dart';
import 'package:demo_ecommerce/features/home/routes/routes.dart';
import 'package:demo_ecommerce/features/product_detail/routes/routes.dart';
import 'package:demo_ecommerce/features/splash/route/routes.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  AppRouter();

  GoRouter get router => _router;

  List<RouteBase> _getRoutes() {
    final List<RouteBase> routes = [];
    routes.addAll(splashRoutes);
    routes.addAll(homeRoutes);
    routes.addAll(productDetailRoutes);
    routes.addAll(cartRoutes);
    return routes;
  }

  late final _router = GoRouter(
      initialLocation: splashPage,
      observers: [ChuckerFlutter.navigatorObserver],
      redirect: (context, state) async {
        return null;
      },
      routes: _getRoutes());
}

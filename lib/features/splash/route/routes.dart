import 'package:demo_ecommerce/features/splash/page/splash_page.dart';
import 'package:go_router/go_router.dart';

const String splashPage = "/splash";

final splashRoutes = [
  GoRoute(
    path: splashPage,
    builder: (context, state) => SplashPage(),
  ),
];

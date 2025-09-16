import 'package:demo_ecommerce/features/home/page/home_page.dart';
import 'package:go_router/go_router.dart';

const String homePage = "/home-page";

final homeRoutes = [
  GoRoute(
    path: homePage,
    builder: (context, state) => HomePage(),
  ),
];

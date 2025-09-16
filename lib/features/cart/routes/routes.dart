import 'package:demo_ecommerce/features/cart/page/cart_page.dart';
import 'package:go_router/go_router.dart';

const String cartPage = "/cart";

final cartRoutes = [
  GoRoute(path: cartPage, builder: (context, state) => CartPage()),
];

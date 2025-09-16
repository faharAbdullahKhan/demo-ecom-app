import 'package:demo_ecommerce/features/product_detail/page/product_detail_page.dart';
import 'package:demo_ecommerce/features/product_detail/routes/extras.dart';
import 'package:go_router/go_router.dart';

const String productDetailPage = "/product-detail";

final productDetailRoutes = [
  GoRoute(
    path: productDetailPage,
    builder:
        (context, state) =>
            ProductDetailPage(extras: state.extra as ProductDetailExtras),
  ),
];

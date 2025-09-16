import 'package:demo_ecommerce/app/router.dart';
import 'package:demo_ecommerce/features/cart/cubit/cart_cubit.dart';
import 'package:demo_ecommerce/features/home/cubit/home_cubit.dart';
import 'package:demo_ecommerce/libraries/base/data/remote/api_service.dart';
import 'package:demo_ecommerce/libraries/products/data/model/products_list_reponse.dart';
import 'package:demo_ecommerce/libraries/products/products_injection.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';

final locator = GetIt.instance;

void _initApiService() {
  locator.registerLazySingleton(() => AppApiService());

  locator.registerLazySingleton(() => RemoteApiService());
}

void _initAppRouter() {
  final appRouter = AppRouter();
  locator.registerLazySingleton(() => appRouter);
}

void _initLibraries() {
  initProductsLibrary();
}

void _initCubit() {
  locator.registerLazySingleton(() => HomeCubit(locator(),locator()));
  locator.registerFactory(() => CartCubit(
    locator(),locator(),locator(),locator()
  ));
}

Future<void> setupDependencies() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ProductsListResponseDtoAdapter());
  Hive.registerAdapter(RatingDtoAdapter());
  await Hive.openBox<ProductsListResponseDto>('products');

}

Future<void> initDI() async {
  _initApiService();
  _initLibraries();
  _initCubit();
  _initAppRouter();
}

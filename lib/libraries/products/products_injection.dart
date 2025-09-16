import 'package:demo_ecommerce/app/injection.dart';
import 'package:demo_ecommerce/libraries/products/data/datasource/cart_local_datasource.dart';
import 'package:demo_ecommerce/libraries/products/data/datasource/product_local_datasource.dart';
import 'package:demo_ecommerce/libraries/products/data/datasource/products_remote_datasource.dart';
import 'package:demo_ecommerce/libraries/products/data/model/products_list_reponse.dart';
import 'package:demo_ecommerce/libraries/products/data/repository/cart_repository.dart';
import 'package:demo_ecommerce/libraries/products/data/repository/products_responsetory_impl.dart';
import 'package:demo_ecommerce/libraries/products/domain/repository/cart_repository_impl.dart';
import 'package:demo_ecommerce/libraries/products/domain/repository/products_repository.dart';
import 'package:demo_ecommerce/libraries/products/domain/usecase/add_to_cart_usecase.dart';
import 'package:demo_ecommerce/libraries/products/domain/usecase/clear_box_uscase.dart';
import 'package:demo_ecommerce/libraries/products/domain/usecase/get_cart_item_usecase.dart';
import 'package:demo_ecommerce/libraries/products/domain/usecase/get_products_usecase.dart';
import 'package:demo_ecommerce/libraries/products/domain/usecase/remove_from_cart_usecase.dart';
import 'package:hive/hive.dart';

initProductsLibrary() async {
  _initProductsRemoteDataSources();
  _initProductsRepositories();
  _initProductsUseCase();
}

void _initProductsRemoteDataSources() {
  locator.registerLazySingleton<ProductsRemoteDatasource>(
    () => ProductsRemoteDatasourceImpl(locator()),
  );
  locator.registerLazySingleton<ProductsLocalDataSource>(
    () => ProductsLocalDataSourceImpl(locator()),
  );

  locator.registerLazySingleton<CartLocalDataSource>(
    () => CartLocalDataSourceImpl(locator()),
  );
}

void _initProductsRepositories() {
  locator.registerLazySingleton<ProductsRepository>(
    () => ProductsRepositoryImpl(locator()),
  );

  locator.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(locator()),
  );
}

void _initProductsUseCase() {
  locator.registerLazySingleton(() => GetCartItemsUseCase(locator()));
  locator.registerLazySingleton(() => AddToCartUseCase(locator()));
  locator.registerLazySingleton(() => RemoveFromCartUseCase(locator()));
  locator.registerLazySingleton(() => GetProductsUsecase(locator()));
  locator.registerLazySingleton(() => ClearBoxUscase(locator()));
}

Future<void> initProductBox() async {
  final productsBox = await Hive.openBox<ProductsListResponseDto>('products');

  locator.registerLazySingleton<Box<ProductsListResponseDto>>(
    () => productsBox,
  );
}

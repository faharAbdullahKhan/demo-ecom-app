import 'package:demo_ecommerce/libraries/products/data/datasource/cart_local_datasource.dart';
import 'package:demo_ecommerce/libraries/products/data/model/products_list_reponse.dart';
import 'package:demo_ecommerce/libraries/products/data/repository/cart_repository.dart';
import 'package:demo_ecommerce/libraries/products/domain/mappr/product_response_mappr.dart';
import 'package:demo_ecommerce/libraries/products/domain/model/products_list_reponse.dart';

class CartRepositoryImpl implements CartRepository {
  final CartLocalDataSource local;
  CartRepositoryImpl(this.local);

  @override
  Future<void> addItem(ProductsListResponse item) async {
    final product = ProductResponseMappr()
        .convert<ProductsListResponse, ProductsListResponseDto>(item);

    return local.saveItem(product);
  }

  @override
  Future<List<ProductsListResponse>> getCartItems() async {
    final productList = await local.getCartItems();
    final product = ProductResponseMappr()
        .convertList<ProductsListResponseDto, ProductsListResponse>(
          productList,
        );

    return product;
  }

  @override
  Future<void> removeItem(int id) => local.deleteItem(id);

  @override
  Future<void> clearCart() => local.clear();
}

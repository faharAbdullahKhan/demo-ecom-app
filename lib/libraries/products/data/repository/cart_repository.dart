import 'package:demo_ecommerce/libraries/products/domain/model/products_list_reponse.dart';

abstract class CartRepository {
  Future<List<ProductsListResponse>> getCartItems();
  Future<void> addItem(ProductsListResponse item);
  Future<void> removeItem(int id);
  Future<void> clearCart();
}

import 'package:demo_ecommerce/libraries/products/data/repository/cart_repository.dart';
import 'package:demo_ecommerce/libraries/products/domain/model/products_list_reponse.dart';

class GetCartItemsUseCase {
  final CartRepository repository;
  GetCartItemsUseCase(this.repository);

  Future<List<ProductsListResponse>> execute() {
    return repository.getCartItems();
  }
}
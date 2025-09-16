import 'package:demo_ecommerce/libraries/products/data/repository/cart_repository.dart';
import 'package:demo_ecommerce/libraries/products/domain/model/products_list_reponse.dart';

class AddToCartUseCase {
  final CartRepository repository;
  AddToCartUseCase(this.repository);

  Future<void> execute(ProductsListResponse item) async {
    await repository.addItem(item);
  }
}
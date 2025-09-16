import 'package:demo_ecommerce/libraries/products/data/repository/cart_repository.dart';

class RemoveFromCartUseCase {
  final CartRepository repository;

  RemoveFromCartUseCase(this.repository);

  Future<void> execute(int id) {
    return repository.removeItem(id);
  }
}
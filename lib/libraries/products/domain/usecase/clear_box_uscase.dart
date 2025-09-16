import 'package:demo_ecommerce/libraries/products/data/repository/cart_repository.dart';

class ClearBoxUscase {
  final CartRepository repository;
  ClearBoxUscase(this.repository);

  Future<void> execute() async {
    await repository.clearCart();
  }
}
import 'package:demo_ecommerce/libraries/products/data/model/products_list_reponse.dart';
import 'package:hive/hive.dart';

abstract class CartLocalDataSource {
  Future<List<ProductsListResponseDto>> getCartItems();
  Future<void> saveItem(ProductsListResponseDto item);
  Future<void> deleteItem(int id);
  Future<void> putItem(ProductsListResponseDto item); // overwrite
  Future<void> clear();
}

class CartLocalDataSourceImpl implements CartLocalDataSource {
  final Box<ProductsListResponseDto> box;
  CartLocalDataSourceImpl(this.box);

  @override
  Future<List<ProductsListResponseDto>> getCartItems() async {
    return box.values.toList();
  }

  @override
  Future<void> saveItem(ProductsListResponseDto item) async {
    final existing = box.get(item.id);
    if (existing != null) {
      final updated = existing.copyWith(
        quantity: existing.quantity + item.quantity,
      );
      await box.put(item.id, updated);
    } else {
      await box.put(item.id, item);
    }
  }

  @override
  Future<void> deleteItem(int id) => box.deleteAt(id);
  @override
  Future<void> putItem(ProductsListResponseDto item) => box.put(item.id, item);
  @override
  Future<void> clear() => box.clear();
}

import 'package:demo_ecommerce/libraries/products/data/model/products_list_reponse.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class ProductsLocalDataSource {
  Future<void> saveProduct(ProductsListResponseDto product);
  List<ProductsListResponseDto> getAllProducts();
  Future<void> clearProducts();
}

class ProductsLocalDataSourceImpl implements ProductsLocalDataSource {
  final Box<ProductsListResponseDto> box;

  ProductsLocalDataSourceImpl(this.box);

  @override
  Future<void> saveProduct(ProductsListResponseDto product) async {
    await box.put(product.id, product); // id as key
  }

  @override
  List<ProductsListResponseDto> getAllProducts() {
    return box.values.toList();
  }

  @override
  Future<void> clearProducts() async {
    await box.clear();
  }
}

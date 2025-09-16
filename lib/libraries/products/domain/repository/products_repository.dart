import 'package:demo_ecommerce/libraries/base/domain/failure.dart';
import 'package:demo_ecommerce/libraries/products/domain/model/products_list_reponse.dart';
import 'package:either_dart/either.dart';

abstract class ProductsRepository {
  Future<Either<Failure, List<ProductsListResponse>>> getProducts();
}

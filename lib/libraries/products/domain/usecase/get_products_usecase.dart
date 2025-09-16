import 'package:demo_ecommerce/libraries/base/domain/failure.dart';
import 'package:demo_ecommerce/libraries/products/domain/model/products_list_reponse.dart';
import 'package:demo_ecommerce/libraries/products/domain/repository/products_repository.dart';
import 'package:either_dart/either.dart';

class GetProductsUsecase {
  GetProductsUsecase(this._repository);

  final ProductsRepository _repository;

  Future<Either<Failure, List<ProductsListResponse>>> execute() async =>
       _repository.getProducts();
}

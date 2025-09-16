import 'package:demo_ecommerce/libraries/base/data/base_repository_impl.dart';
import 'package:demo_ecommerce/libraries/base/domain/failure.dart';
import 'package:demo_ecommerce/libraries/products/data/datasource/product_local_datasource.dart';
import 'package:demo_ecommerce/libraries/products/data/datasource/products_remote_datasource.dart';
import 'package:demo_ecommerce/libraries/products/data/model/products_list_reponse.dart';
import 'package:demo_ecommerce/libraries/products/domain/mappr/product_response_mappr.dart';
import 'package:demo_ecommerce/libraries/products/domain/model/products_list_reponse.dart';
import 'package:demo_ecommerce/libraries/products/domain/repository/products_repository.dart';
import 'package:either_dart/either.dart';

class ProductsRepositoryImpl extends BaseRepositoryImpl
    implements ProductsRepository {
  final ProductsRemoteDatasource _dataSource;
  final ProductsLocalDataSource? _localDataSource;

  ProductsRepositoryImpl(
      this._dataSource, {
        ProductsLocalDataSource? localDataSource,
      }) : _localDataSource = localDataSource;

  @override
  Future<Either<Failure, List<ProductsListResponse>>> getProducts({
    bool useLocal = false,
    bool forceRemote = false,
  }) async {
    try {
      if (useLocal && _localDataSource != null && !forceRemote) {
        final localSource = _localDataSource!.getAllProducts();
        if (localSource.isNotEmpty) {
          final domain =
          ProductResponseMappr().convertList<ProductsListResponseDto, ProductsListResponse>(localSource);
          return Right(domain);
        }
      }

      final result = await _dataSource.getProducts();
      if (result.hasError) {
        return Left(getFailureFromErrorReponse(result));
      }

      final List<ProductsListResponseDto> products = ((result.data) as List)
          .map((i) => ProductsListResponseDto.fromJson(i as Map<String, dynamic>))
          .toList();

      if (_localDataSource != null) {
        await _localDataSource.saveProduct(ProductResponseMappr().convert(products));
      }

      final domain =
      ProductResponseMappr().convertList<ProductsListResponseDto, ProductsListResponse>(products);
      return Right(domain);
    } catch (e) {

      return Left(RequestFailure(e.toString()));
    }
  }
}

import 'package:demo_ecommerce/libraries/base/data/remote/api_response.dart';
import 'package:demo_ecommerce/libraries/base/data/remote/api_service.dart';
import 'package:demo_ecommerce/libraries/products/data/datasource/endpoints.dart';

abstract class ProductsRemoteDatasource {
  Future<ApiResponse> getProducts();
}

class ProductsRemoteDatasourceImpl implements ProductsRemoteDatasource {
  ProductsRemoteDatasourceImpl(this._apiService);

  final AppApiService _apiService;

  @override
  Future<ApiResponse> getProducts() async {
    return await _apiService.get(productsListUrl);
  }
}

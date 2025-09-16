import 'package:auto_mappr_annotation/auto_mappr_annotation.dart';
import 'package:demo_ecommerce/libraries/products/data/model/products_list_reponse.dart';
import 'package:demo_ecommerce/libraries/products/domain/mappr/product_response_mappr.auto_mappr.dart';
import 'package:demo_ecommerce/libraries/products/domain/model/products_list_reponse.dart';

@AutoMappr([
  MapType<ProductsListResponseDto, ProductsListResponse>(),
  MapType<ProductsListResponse, ProductsListResponseDto>(),
  MapType<RatingDto, Rating>(),
  MapType<Rating, RatingDto>(),
])
class ProductResponseMappr extends $ProductResponseMappr {}

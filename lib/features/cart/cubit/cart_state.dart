part of 'cart_cubit.dart';


@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class Loading extends CartState {
  final bool isLoading;

  Loading(this.isLoading);
}

class ProductsFetched extends CartState{
  final List<ProductsListResponse> items;
  final String total;
  ProductsFetched(this.items, this.total);
}

class ProductsFetchingFailed extends CartState{
  final String error;
  ProductsFetchingFailed(this.error);
}


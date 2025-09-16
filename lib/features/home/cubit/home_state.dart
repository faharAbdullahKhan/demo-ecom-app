part of 'home_cubit.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class Loading extends HomeState {
  final bool isLoading;

  Loading(this.isLoading);
}

final class ProductFetchedFailed extends HomeState {
  final Failure failure;

  ProductFetchedFailed(this.failure);
}

final class ProductFetchedSuccess extends HomeState {
  final List<ProductsListResponse> products;

  ProductFetchedSuccess(this.products);
}

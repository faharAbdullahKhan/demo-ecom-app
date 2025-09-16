import 'package:demo_ecommerce/libraries/products/domain/model/products_list_reponse.dart';
import 'package:demo_ecommerce/libraries/products/domain/usecase/add_to_cart_usecase.dart';
import 'package:demo_ecommerce/libraries/products/domain/usecase/clear_box_uscase.dart';
import 'package:demo_ecommerce/libraries/products/domain/usecase/get_cart_item_usecase.dart';
import 'package:demo_ecommerce/libraries/products/domain/usecase/remove_from_cart_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final GetCartItemsUseCase _getCartItems;
  final AddToCartUseCase _addToCart;
  final RemoveFromCartUseCase _removeFromCart;
  final ClearBoxUscase _clearBoxUscase;

  CartCubit(
    this._getCartItems,
    this._addToCart,
    this._removeFromCart,
    this._clearBoxUscase,
  ) : super(CartInitial());

  Future<void> loadCart() async {
    emit(Loading(true));
    try {
      final items = await _getCartItems.execute();
    final total = await _getCartTotal(items);
      emit(Loading(false));
      emit(ProductsFetched(items,total.toString()));
    } catch (e) {
      emit(Loading(false));

      emit(ProductsFetchingFailed(e.toString()));
    }
  }

  Future<int> _getCartTotal(List<ProductsListResponse> products) async {
    return products.fold<int>(
      0,
          (sum, item) => sum + (item.price).toInt(),
    );
  }

  Future<void> addItem(ProductsListResponse product) async {
    await _addToCart.execute(product);
    await loadCart();
  }

  Future<void> removeItem(int id) async {
    await _removeFromCart.execute(id);
    await loadCart();
  }

  @override
  Future<void> close() async {
    await _clearBoxUscase.execute();
    return super.close();
  }
}

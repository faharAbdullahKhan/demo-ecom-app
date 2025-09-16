import 'dart:async';

import 'package:demo_ecommerce/libraries/base/domain/failure.dart';
import 'package:demo_ecommerce/libraries/products/domain/model/products_list_reponse.dart';
import 'package:demo_ecommerce/libraries/products/domain/usecase/add_to_cart_usecase.dart';
import 'package:demo_ecommerce/libraries/products/domain/usecase/get_products_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetProductsUsecase _getProductsUsecase;
  final AddToCartUseCase _addToCart;

  List<ProductsListResponse> _products = [];
  String _currentQuery = '';
  String? _currentCategory;

  final Box<ProductsListResponse>? productsBox;
  bool useLocalData = false;
  StreamSubscription<BoxEvent>? _boxSubscription;

  HomeCubit(
    this._getProductsUsecase,
    this._addToCart, {
    this.productsBox,
    this.useLocalData = false,
  }) : super(HomeInitial()) {
    if (useLocalData && productsBox != null) {
      _loadFromBox();
      _watchBox();
    }
  }

  void _loadFromBox() {
    if (productsBox == null) return;
    final boxValues = productsBox!.values.toList(growable: false);
    _products = List<ProductsListResponse>.from(boxValues);
    _applyFiltersAndEmit();
  }

  void _watchBox() {
    if (productsBox == null) return;
    _cancelBoxWatch();
    _boxSubscription = productsBox!.watch().listen((event) {
      _loadFromBox();
    });
  }

  void _cancelBoxWatch() {
    _boxSubscription?.cancel();
    _boxSubscription = null;
  }

  List<String> get availableCategories {
    final set = <String>{};
    for (final product in _products) {
      if (product.category.isNotEmpty) {
        set.add(product.category);
      }
    }
    return set.toList();
  }

  Future<void> setUseLocalData(bool useLocal) async {
    if (useLocalData == useLocal) return;
    useLocalData = useLocal;

    if (useLocalData) {
      if (productsBox == null) {
        await getProducts(forceRefresh: true);
        return;
      }
      _loadFromBox();
      _watchBox();
    } else {
      _cancelBoxWatch();
      await getProducts(forceRefresh: true);
    }
  }

  Future<void> getProducts({bool forceRefresh = false}) async {
    if (useLocalData && productsBox != null) {
      _loadFromBox();
      return;
    }

    if (_products.isNotEmpty && !forceRefresh) {
      _applyFiltersAndEmit();
      return;
    }

    emit(Loading(true));
    final result = await _getProductsUsecase.execute();
    result.fold(
      (failure) {
        emit(Loading(false));
        emit(ProductFetchedFailed(failure));
      },
      (success) {
        emit(Loading(false));
        _products = List<ProductsListResponse>.from(success);
        _applyFiltersAndEmit();
      },
    );
  }

  void searchProducts(String query) {
    _currentQuery = query.trim();
    _applyFiltersAndEmit();
  }

  void filterByCategory(String? category) {
    final normalized =
        (category == null || category.trim().isEmpty) ? null : category;
    _currentCategory = normalized;
    _applyFiltersAndEmit();
  }

  void _applyFiltersAndEmit() {
    if (_products.isEmpty) {
      if (useLocalData && productsBox != null) {
        _loadFromBox();
        return;
      }
      getProducts();
      return;
    }

    final q = _currentQuery.toLowerCase();

    final filtered =
        _products.where((p) {
          if (_currentCategory != null && _currentCategory!.isNotEmpty) {
            if ((p.category).toLowerCase() != _currentCategory!.toLowerCase()) {
              return false;
            }
          }
          if (q.isNotEmpty) {
            final title = (p.title).toLowerCase();
            return title.contains(q);
          }
          return true;
        }).toList();

    emit(ProductFetchedSuccess(filtered));
  }

  void clearFilters() {
    _currentQuery = '';
    _currentCategory = null;
    _applyFiltersAndEmit();
  }

  void clearCache() {
    _products = [];
  }

  Future<void> addItem(ProductsListResponse product) async {
    await _addToCart.execute(product);
  }

  @override
  Future<void> close() {
    _cancelBoxWatch();
    return super.close();
  }
}

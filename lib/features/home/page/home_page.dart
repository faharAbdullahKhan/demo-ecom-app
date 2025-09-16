import 'package:demo_ecommerce/app/constants/values.dart';
import 'package:demo_ecommerce/app/injection.dart';
import 'package:demo_ecommerce/features/base/mixins/base_page.dart';
import 'package:demo_ecommerce/features/base/style/color.dart';
import 'package:demo_ecommerce/features/base/style/dimension.dart';
import 'package:demo_ecommerce/features/base/style/style.dart';
import 'package:demo_ecommerce/features/base/widgets/appbar.dart';
import 'package:demo_ecommerce/features/base/widgets/button.dart';
import 'package:demo_ecommerce/features/base/widgets/input_text_field.dart';
import 'package:demo_ecommerce/features/base/widgets/label.dart';
import 'package:demo_ecommerce/features/cart/routes/routes.dart';
import 'package:demo_ecommerce/features/home/cubit/home_cubit.dart';
import 'package:demo_ecommerce/features/home/widgets/filter_bottom_sheet.dart';
import 'package:demo_ecommerce/features/home/widgets/product_card.dart';
import 'package:demo_ecommerce/features/product_detail/routes/extras.dart';
import 'package:demo_ecommerce/features/product_detail/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:go_router/go_router.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomePage extends StatelessWidget with BasePage {
  HomePage({super.key});

  final _homeCubit = locator<HomeCubit>();
  final TextEditingController _searchTextController = TextEditingController();

  final RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  void _onRefresh() async {
    _homeCubit.clearCache();
    _homeCubit.clearFilters();
    _homeCubit.getProducts();
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    _homeCubit.getProducts();
    _refreshController.loadComplete();
  }

  void _handleStates(BuildContext context, HomeState state) {
    switch (state) {
      case Loading():
        state.isLoading
            ? showLoadingIndicator(context)
            : stopLoadingIndicator(context);

      case ProductFetchedFailed():
        showFailureMessage(context, state.failure);

      default:
        {}
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBar = Appbar(
      action: Padding(
        padding: EdgeInsets.symmetric(horizontal: width10),
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => context.push(cartPage),
          child: Icon(
            Icons.shopping_bag_outlined,
            color: AppColor.onPrimary,
            size: size30,
          ),
        ),
      ),
    );

    final filterWidget = Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        SizedBox(width: width10),
        Expanded(
          child: InputTextField(
            hintText: search,
            labelText: "",
            controller: _searchTextController,
            showErrorBorder: false,
            onValueChanged: (value) {
              _homeCubit.searchProducts(value);
            },
          ),
        ),
        Button(
          onPressed: () {
            showBottomSheetWidget(
              context,
              FilterBottomSheet(
                filters: _homeCubit.availableCategories,
                onReasonSelected: (selectedFilter) {
                  _homeCubit.filterByCategory(selectedFilter);
                },
                title: filters,
                btnLabel: select,
              ),
            );
          },
          prefixIcon: Icon(Icons.filter_list_alt),
          color: AppColor.onPrimary,
        ),
      ],
    );

    final productsGridView = BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) => current is ProductFetchedSuccess,
      builder: (context, state) {
        return SmartRefresher(
          controller: _refreshController,
          onLoading: _onLoading,
          onRefresh: _onRefresh,
          child:
          state is ProductFetchedSuccess && state.products.isNotEmpty
              ? MasonryGridView.count(
            padding: EdgeInsets.all(size10),
            crossAxisCount: 2,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12,
            shrinkWrap: true,
            itemCount: state.products.length,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius16),
                ),
                elevation: 2,
                child: ProductCard(
                  product: state.products[index],
                  onPressed: () {
                    context.push(
                      productDetailPage,
                      extra: ProductDetailExtras(
                        product: state.products[index],
                      ),
                    );
                  },
                ),
              );
            },
          )
              : Center(
            child: Label(noProductsListed, style: boldP1TextStyle),
          ),
        );
      },
    );

    return BlocProvider.value(
      value: _homeCubit,
      child: BlocListener<HomeCubit, HomeState>(
        listener: _handleStates,
        child: FocusDetector(
          onFocusGained: () => _homeCubit.setUseLocalData(true),
          child: Scaffold(
            appBar: appBar,
            body: Column(
              children: [filterWidget, Expanded(child: productsGridView)],
            ),
          ),
        ),
      ),
    );
  }
}

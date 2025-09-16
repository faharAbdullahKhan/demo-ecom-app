import 'package:demo_ecommerce/app/constants/values.dart';
import 'package:demo_ecommerce/app/injection.dart';
import 'package:demo_ecommerce/features/base/mixins/base_page.dart';
import 'package:demo_ecommerce/features/base/style/color.dart';
import 'package:demo_ecommerce/features/base/style/dimension.dart';
import 'package:demo_ecommerce/features/base/style/style.dart';
import 'package:demo_ecommerce/features/base/widgets/appbar.dart';
import 'package:demo_ecommerce/features/base/widgets/label.dart';
import 'package:demo_ecommerce/features/base/widgets/snackbar.dart';
import 'package:demo_ecommerce/features/cart/cubit/cart_cubit.dart';
import 'package:demo_ecommerce/features/cart/widget/cart_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_detector/focus_detector.dart';

class CartPage extends StatelessWidget with BasePage {
  CartPage({super.key});

  final _cartCubit = locator<CartCubit>();

  void _handleStates(BuildContext context, CartState state) {
    switch (state) {
      case Loading():
        state.isLoading
            ? showLoadingIndicator(context)
            : stopLoadingIndicator(context);

      case ProductsFetchingFailed():
        Snackbar.show(
          context,
          title: state.error,
          type: MessageType.error,
          isTop: false,
        );
      default:
        {}
    }
  }

  @override
  Widget build(BuildContext context) {
    final appBar = Appbar(
      showLeading: true,
      title: Label(
        cart,
        style: boldP1TextStyle.copyWith(color: AppColor.onPrimary),
      ),
    );

    final cartCard = BlocBuilder<CartCubit, CartState>(
      buildWhen: (previous, current) => current is ProductsFetched,
      builder: (context, state) {
        return state is ProductsFetched && state.items.isNotEmpty
            ? ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius16),
                  ),
                  elevation: 2,
                  child: CartCard(
                    image: state.items[index].image,
                    name: state.items[index].image,
                    price: state.items[index].price.toInt(),
                    description: state.items[index].description,
                    onRemove: () {
                      _cartCubit.removeItem(index);
                    },
                  ),
                );
              },
            )
            : Center(child: Label(emptyCart, style: boldP1TextStyle));
      },
    );

    final totalWidget = BlocBuilder<CartCubit, CartState>(
      buildWhen: (previous, current) => current is ProductsFetched,
      builder: (context, state) {
        return Row(
          children: [
            Label("Total", style: boldB1TextStyle),
            Spacer(),
            state is ProductsFetched
                ? Label("\$ ${state.total}", style: boldB1TextStyle)
                : Label("\$ 0.0", style: boldB1TextStyle),
          ],
        );
      },
    );

    return BlocProvider.value(
      value: _cartCubit,
      child: BlocListener<CartCubit, CartState>(
        listener: _handleStates,
        child: FocusDetector(
          onFocusGained: () => _cartCubit.loadCart(),
          child: Scaffold(
            appBar: appBar,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [Expanded(child: cartCard), totalWidget],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

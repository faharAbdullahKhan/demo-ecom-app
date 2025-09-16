import 'package:demo_ecommerce/app/injection.dart';
import 'package:demo_ecommerce/features/base/style/color.dart';
import 'package:demo_ecommerce/features/base/style/dimension.dart';
import 'package:demo_ecommerce/features/base/style/style.dart';
import 'package:demo_ecommerce/features/base/widgets/appbar.dart';
import 'package:demo_ecommerce/features/base/widgets/button.dart';
import 'package:demo_ecommerce/features/base/widgets/image_network.dart';
import 'package:demo_ecommerce/features/base/widgets/label.dart';
import 'package:demo_ecommerce/features/cart/routes/routes.dart';
import 'package:demo_ecommerce/features/home/cubit/home_cubit.dart';
import 'package:demo_ecommerce/features/product_detail/routes/extras.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';

class ProductDetailPage extends StatelessWidget {
  final ProductDetailExtras extras;

  ProductDetailPage({super.key, required this.extras});

  final _homeCubit = locator<HomeCubit>();

  @override
  Widget build(BuildContext context) {
    final appBar = Appbar(
      showLeading: true,
    );

    final ratingWidget = RatingBarIndicator(
      rating: extras.product.rating.rate,
      itemBuilder: (context, index) => const Icon(Icons.star, size: 16),
      itemCount: 5,
      itemSize: 16.0,
      direction: Axis.horizontal,
    );

    final addToCartButton = Button(
      onPressed: () {
        _homeCubit.addItem(extras.product);
        context.push(cartPage);
      },
      text: "Add to cart",
      prefixIcon: Icon(Icons.shopping_bag_outlined, color: AppColor.onPrimary,),
    );

    return BlocProvider.value(
      value: _homeCubit,
      child: Scaffold(
        appBar: appBar,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(size10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Center(
                    child: ImageNetwork(
                      image: extras.product.image,
                      errorWidget: SizedBox.shrink(),
                    ),
                  ),
                ),
                SizedBox(height: height10),
                Label(extras.product.title, style: boldB2TextStyle),
                SizedBox(height: height10),
                Label(extras.product.description, style: mediumP2TextStyle),
                SizedBox(height: height10),
                Label(
                  "\$ ${extras.product.price.toString()}",
                  style: mediumP1TextStyle,
                ),
                SizedBox(height: height05),
                Label(
                  extras.product.rating.rate.toString(),
                  style: mediumP1TextStyle,
                ),
                SizedBox(height: height05),
                ratingWidget,
                Spacer(),
                addToCartButton,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

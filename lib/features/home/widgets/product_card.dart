import 'package:demo_ecommerce/features/base/style/color.dart';
import 'package:demo_ecommerce/features/base/style/dimension.dart';
import 'package:demo_ecommerce/features/base/style/style.dart';
import 'package:demo_ecommerce/features/base/widgets/image_network.dart';
import 'package:demo_ecommerce/features/base/widgets/label.dart';
import 'package:demo_ecommerce/libraries/products/domain/model/products_list_reponse.dart';
import 'package:flutter/material.dart';

class ProductCard extends StatelessWidget {
  final ProductsListResponse product;
  final Function() onPressed;
  const ProductCard({super.key, required this.product, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width06, vertical: height05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: height10),
            Center(
              child: ImageNetwork(
                image: product.image,
                errorWidget: Icon(Icons.image, color: AppColor.primary),
              ),
            ),

            SizedBox(height: height10),
            Label(product.title, style: boldP2TextStyle),
            SizedBox(height: height05),
            Label(
              product.category,
              style: boldP3TextStyle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),

            SizedBox(height: height05),
            Label("\$ ${product.price.toString()}", style: boldP3TextStyle),
          ],
        ),
      ),
    );
  }
}

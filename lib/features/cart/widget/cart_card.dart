import 'package:demo_ecommerce/features/base/style/dimension.dart';
import 'package:demo_ecommerce/features/base/style/style.dart';
import 'package:demo_ecommerce/features/base/widgets/image_network.dart';
import 'package:demo_ecommerce/features/base/widgets/label.dart';
import 'package:flutter/material.dart';

class CartCard extends StatelessWidget {
  final String image;
  final String name;
  final int price;
  final String description;
  final void Function() onRemove;
  const CartCard({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.description,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(size08),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageNetwork(
            height: height100,
            width: width100,
            image: image,
            errorWidget: Icon(Icons.photo, size:  size60),
          ),
          SizedBox(width: width10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Label(name, style: boldP1TextStyle),
                SizedBox(height: height10),
                Label("\$ ${price.toString()}", style: mediumP2TextStyle),
                SizedBox(height: height10),
                Label(description, style: mediumP2TextStyle),
              ],
            ),
          ),
          SizedBox(width: width10),

          GestureDetector(onTap: onRemove, child: Icon(Icons.delete)),
        ],
      ),
    );
  }
}

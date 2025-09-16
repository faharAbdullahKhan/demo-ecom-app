import 'package:flutter/material.dart';

class ImageNetwork extends StatelessWidget {
  final String image;
  final double? height;
  final double? width;
  final Widget errorWidget;
  const ImageNetwork(
      {super.key,
      required this.image,
      this.height,
      this.width,
      required this.errorWidget});

  @override
  Widget build(BuildContext context) {
    return Image.network(
      image,
      width: width,
      height: height,
      fit: BoxFit.fill,
      errorBuilder: (context, error, stackTrace) => errorWidget,
    );
  }
}

import 'package:demo_ecommerce/features/base/style/style.dart';
import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String text;
  final int? maxLines;
  final TextStyle? style;
  final TextAlign textAlign;
  final TextOverflow? overflow;
  const Label(this.text,
      {super.key,
      this.maxLines,
      this.overflow,
      this.textAlign = TextAlign.start,
      this.style});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      softWrap: true,
      overflow: overflow,
      textAlign: textAlign,
      style: style ?? regularP1TextStyle,
    );
  }
}

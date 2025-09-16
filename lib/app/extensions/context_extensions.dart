import 'package:flutter/material.dart';

extension SizeExtension on BuildContext {
  Size get size => MediaQuery.of(this).size;

  double get screenWidth => size.width;
  double get screenHeight => size.height;

  double get bottomInset => MediaQuery.of(this).viewInsets.bottom;

  Offset get centerOffsetWithAdjustment => size.center(const Offset(0, -140));

}

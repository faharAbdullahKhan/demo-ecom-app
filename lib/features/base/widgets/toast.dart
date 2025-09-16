import 'package:demo_ecommerce/features/base/style/color.dart';
import 'package:demo_ecommerce/features/base/style/dimension.dart';
import 'package:demo_ecommerce/features/base/style/style.dart';
import 'package:demo_ecommerce/features/base/widgets/label.dart';
import 'package:flutter/material.dart';

enum ToastType {
  success,
  error,
  disabled,
}

class Toast extends StatelessWidget {
  final String text;
  final ToastType toastType;

  const Toast({
    super.key,
    required this.text,
    this.toastType = ToastType.error,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width08),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: toastType == ToastType.error
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        children: [
          getIcon(),
          SizedBox(
            width: width07,
          ),
          Flexible(
            child: Label(
              text,
              style: regularP2TextStyle.copyWith(color: getColor()),
            ),
          )
          ,
        ],
      ),
    );
  }

  Icon getIcon() {
    switch (toastType) {
      case ToastType.success:
        return Icon(
          Icons.check,
          color: AppColor.success,
          size: borderRadius16,
        );
      case ToastType.disabled:
        return Icon(
          Icons.check,
          color: AppColor.hintColor,
          size: borderRadius16,
        );
      default:
        return Icon(
          Icons.error,
          color: AppColor.error,
          size: borderRadius16,
        );
    }
  }

  Color getColor() {
    switch (toastType) {
      case ToastType.success:
        return AppColor.primary;
      case ToastType.disabled:
        return AppColor.hintColor;

      default:
        return AppColor.error;
    }
  }
}

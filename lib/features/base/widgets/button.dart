import 'package:demo_ecommerce/features/base/style/color.dart';
import 'package:demo_ecommerce/features/base/style/dimension.dart';
import 'package:demo_ecommerce/features/base/style/style.dart';
import 'package:demo_ecommerce/features/base/widgets/label.dart';
import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String? text;
  final bool isFilled;
  final Function() onPressed;
  final bool enabled;
  final Color? color;
  final Color? textColor;
  final TextStyle? textStyle;
  final Color? borderColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  const Button(
      {super.key,
      this.text,
      this.enabled = true,
      this.textColor,
      required this.onPressed,
      this.borderColor,
      this.color,
      this.prefixIcon,
      this.suffixIcon,
      this.isFilled = true, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: enabled ? onPressed : null,
      child: Container(
          padding:
              EdgeInsets.symmetric(vertical: height16, horizontal: width12),
          decoration: BoxDecoration(
              gradient: enabled && isFilled && color == null
                  ? const LinearGradient(
                      colors: [
                        AppColor.primary,
                        AppColor.primary,
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    )
                  : null,
              color: enabled
                  ? (isFilled
                      ? (color ?? AppColor.primary)
                      : Colors.transparent)
                  : AppColor.disabledColor,
              borderRadius: BorderRadius.circular(borderRadius200),
              border: isFilled && borderColor == null
                  ? null
                  : Border.all(color: (borderColor ?? AppColor.primary))),
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (prefixIcon != null) prefixIcon!,
                if (prefixIcon != null && text != null)
                  SizedBox(width: width10,),
                if (text != null)
                  Label(
                    text!,
                    style: textStyle ?? buttonTextStyle.copyWith(
                        color: isFilled
                            ? (textColor ?? AppColor.onPrimary)
                            : (textColor ?? AppColor.primary)),
                  ),

                if (suffixIcon != null && text != null)
                  Spacer(),

                if (suffixIcon != null) suffixIcon!,
              ],
            ),
          )),
    );
  }
}

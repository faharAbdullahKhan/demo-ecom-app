import 'package:demo_ecommerce/features/base/style/color.dart';
import 'package:demo_ecommerce/features/base/style/dimension.dart';
import 'package:demo_ecommerce/features/base/style/style.dart';
import 'package:demo_ecommerce/features/base/widgets/label.dart';
import 'package:demo_ecommerce/features/base/widgets/safe_area_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomSheetWidget extends StatelessWidget {
  final Widget child;
  final String title;
  final String? message;
  final bool isDismissable;

  const BottomSheetWidget(
      {super.key,
      required this.child,
      required this.title,
      this.message,
      this.isDismissable = true});

  @override
  Widget build(BuildContext context) {
    final bottomSheetAppBar = title.isNotEmpty
        ? Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Label(
                      title,
                      style: boldP1TextStyle,
                    ),
                    if (message != null) ...[
                      Label(
                        message!,
                        style: regularP3TextStyle,
                      ),
                    ]
                  ],
                ),
              ),
              SizedBox(
                width: width20,
              ),
              if (isDismissable)
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => context.pop(),
                  child: Icon(
                    Icons.cancel_rounded,
                    size: size30,
                    color: AppColor.transparentPrimary,
                  ),
                )
            ],
          )
        : const SizedBox.shrink();

    return SafeAreaWidget(
      child: Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            right: pageHorizontalMargin,
            left: pageHorizontalMargin,
            top: height20),
        decoration: BoxDecoration(
            color: AppColor.secondaryBackgroundColor,
            borderRadius:
                BorderRadius.vertical(top: Radius.circular(borderRadius20))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            bottomSheetAppBar,
            SizedBox(
              height: height16,
            ),
            child,
            SizedBox(
              height: height16,
            ),
          ],
        ),
      ),
    );
  }
}

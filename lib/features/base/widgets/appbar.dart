import 'package:demo_ecommerce/features/base/style/color.dart';
import 'package:demo_ecommerce/features/base/style/dimension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class Appbar extends StatelessWidget implements PreferredSizeWidget{
  final Widget? title;
  final Widget? action;
  final bool showLeading;

  const Appbar({super.key, this.title,this.showLeading = false, this.action});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColor.primary,
      title: title,
      leading: showLeading
          ? GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => context.pop(),
          child: Icon(
            Icons.arrow_back,
            color: AppColor.onPrimary,
            size: size24,
          ))
          : const SizedBox(),
      actions: [
        action ?? const SizedBox.shrink(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

}

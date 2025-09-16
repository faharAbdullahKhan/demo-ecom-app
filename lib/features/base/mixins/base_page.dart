import 'package:demo_ecommerce/app/constants/values.dart';
import 'package:demo_ecommerce/features/base/style/color.dart';
import 'package:demo_ecommerce/features/base/widgets/snackbar.dart';
import 'package:demo_ecommerce/libraries/base/domain/failure.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

mixin BasePage {
  void showFailureMessage(
    BuildContext context,
    Failure failure, {
    bool isTop = false,
  }) {
    switch (failure) {
      case RequestFailure():
        Snackbar.show(
          context,
          title: failure.error,
          type: MessageType.error,
          isTop: isTop,
        );
      case NotFoundFailure():
        Snackbar.show(
          context,
          title: failure.error,
          type: MessageType.error,
          isTop: isTop,
        );
      case ConnectionFailure():
        Snackbar.show(
          context,
          title: connectionIssue,
          message: pleaseCheckYourConnection,
          type: MessageType.warning,
          isTop: isTop,
        );
      default:
        Snackbar.show(
          context,
          title: somethingWrong,
          type: MessageType.warning,
          isTop: isTop,
        );
    }
  }

  void showBottomSheetWidget(
    BuildContext context,
    Widget child, {
    Color backgroundColor = Colors.transparent,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      barrierColor: backgroundColor, // darken background
      builder: (BuildContext context) {
        return child;
      },
    );
  }

  void showLoadingIndicator(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(color: AppColor.primary),
        );
      },
      context: context,
    );
  }

  void stopLoadingIndicator(BuildContext context) {
    context.pop();
  }
}

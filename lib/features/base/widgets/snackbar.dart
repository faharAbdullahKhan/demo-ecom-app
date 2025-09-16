import 'package:demo_ecommerce/features/base/style/color.dart';
import 'package:demo_ecommerce/features/base/style/dimension.dart';
import 'package:demo_ecommerce/features/base/style/style.dart';
import 'package:demo_ecommerce/features/base/widgets/label.dart';
import 'package:demo_ecommerce/features/base/widgets/safe_area_widget.dart';
import 'package:flutter/material.dart';

class Snackbar extends StatelessWidget {
  final String title;
  final String? message;
  final MessageType type;
  final Function? onActionPressed;

  const Snackbar({
    super.key,
    required this.title,
    this.message,
    required this.type,
    this.onActionPressed,
  });

  static final List<OverlayEntry> _overlayEntries = [];

  static void show(BuildContext context,
      {required String title,
      String? message,
      required MessageType type,
      Function? onActionPressed,
      final bool isTop = false,
      bool isPersistent = false}) {
    final overlay = Overlay.of(context);
    double topPosition = isTop ? 50 + (_overlayEntries.length * 100) : 50;
    double bottomPosition = isTop ? 50 : 25 + (_overlayEntries.length * 100);

    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: isTop ? topPosition : null,
        bottom: isTop ? null : bottomPosition,
        left: 25,
        right: 25,
        child: Material(
          color: Colors.transparent,
          child: Snackbar(
            title: title,
            message: message,
            type: type,
            onActionPressed: () {
              if (onActionPressed != null) {
                onActionPressed();
              }
              _removeSnackbar(overlayEntry);
            },
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    _overlayEntries.add(overlayEntry);
    if (!isPersistent) {
      Future.delayed(const Duration(seconds: 3), () {
        overlayEntry.remove();
        _overlayEntries.remove(overlayEntry);
        _repositionSnackbars();
      });
    }
  }

  static void _removeSnackbar(OverlayEntry entry) {
    if (_overlayEntries.contains(entry)) {
      entry.remove();
      _overlayEntries.remove(entry);
      _repositionSnackbars();
    }
  }

  static void _repositionSnackbars() {
    for (int i = 0; i < _overlayEntries.length; i++) {
      final overlayEntry = _overlayEntries[i];
      overlayEntry.markNeedsBuild();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SnackBarWidget(
      title: title,
      type: type,
      message: message,
      onActionPressed: onActionPressed,
    );
  }
}

enum MessageType {
  warning,
  error,
  success;
}

class SnackBarWidget extends StatelessWidget {
  final String title;
  final String? message;
  final MessageType type;
  final Widget? action;
  final Function? onActionPressed;

  const SnackBarWidget({
    super.key,
    required this.title,
    this.message,
    this.action,
    required this.type,
    this.onActionPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeAreaWidget(
        child: Container(
      padding: EdgeInsets.symmetric(horizontal: width16, vertical: height12),
      decoration: BoxDecoration(
        color: AppColor.toastColor,
        borderRadius: BorderRadius.circular(borderRadius08),
      ),
      child: Row(
        children: [
          Container(
            padding:
                EdgeInsets.symmetric(horizontal: width05, vertical: height05),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(  borderRadius100),
              color: _getIconBackgroundColor().withOpacity(0.15),
            ),
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: width05, vertical: height05),
              decoration: BoxDecoration(
                color: _getIconBackgroundColor(),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getIcon(),
                color: AppColor.toastColor,
                size: size14,
              ),
            ),
          ),
          SizedBox(width: width12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Label(
                  title,
                  style: boldP2TextStyle.copyWith(color: AppColor.onToastColor),
                ),
                if (message != null)
                  Label(
                    message!,
                    style: regularP2TextStyle.copyWith(
                        color: AppColor.descriptionColor),
                  ),
              ],
            ),
          ),
          SizedBox(width: width12),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              if (onActionPressed != null) {
                onActionPressed!();
              }
            },
            child: action != null
                ? action!
                : Icon(
                    Icons.close,
                    size: size24,
                    color: AppColor.onToastColor,
                  ),
          ),
        ],
      ),
    ));
  }

  IconData _getIcon() {
    switch (type) {
      case MessageType.success:
        return Icons.done;
      case MessageType.error:
        return Icons.close;
      case MessageType.warning:
        return Icons.priority_high;
    }
  }

  Color _getIconBackgroundColor() {
    switch (type) {
      case MessageType.error:
        return AppColor.error;
      case MessageType.success:
        return AppColor.success;
      case MessageType.warning:
        return AppColor.warning;
    }
  }
}

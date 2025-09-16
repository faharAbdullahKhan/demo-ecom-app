import 'package:demo_ecommerce/app/constants/values.dart';
import 'package:demo_ecommerce/features/base/style/color.dart';
import 'package:demo_ecommerce/features/base/style/dimension.dart';
import 'package:demo_ecommerce/features/base/style/style.dart';
import 'package:demo_ecommerce/features/base/widgets/bottom_sheet_widget.dart';
import 'package:demo_ecommerce/features/base/widgets/button.dart';
import 'package:demo_ecommerce/features/base/widgets/label.dart';
import 'package:demo_ecommerce/features/base/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FilterBottomSheet extends StatefulWidget {
  final List<String> filters;
  final String btnLabel;
  final String title;
  final Function(String filter) onReasonSelected;

  const FilterBottomSheet(
      {super.key,
      required this.filters,
      required this.onReasonSelected,
        required this.title,
      required this.btnLabel});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  int? selectedIndex;

  bool isReasonSelected() => selectedIndex != -1;

  @override
  Widget build(BuildContext context) {

    final toastWidget = isReasonSelected()
        ? const SizedBox()
        : Toast(text: pleaseSelectValidFilter);

    final button = Button(
        text: widget.btnLabel,
        onPressed: () {
          final isValid = selectedIndex != null && isReasonSelected();
          if (isValid) {
            context.pop();
            widget.onReasonSelected(widget.filters[selectedIndex!]);
          } else {
            setState(() {
              selectedIndex = -1;
            });
          }
        });

    final reasonsList = Container(
      padding: EdgeInsets.symmetric(horizontal: width05, vertical: height10),
      decoration: BoxDecoration(
          color: AppColor.onPrimary,
          borderRadius: BorderRadius.circular(borderRadius16)),
      child: ListView.builder(
          itemCount: widget.filters.length,
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          itemBuilder: (context, index) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: height05, horizontal: width10),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () => setState(() {
                      selectedIndex = index;
                    }),
                    child: Row(
                      children: [
                        Label(
                          widget.filters[index],
                          style: mediumP1TextStyle,
                        ),
                        const Spacer(),
                        if (selectedIndex == index)
                          Icon(Icons.check_circle),
                      ],
                    ),
                  ),
                ),
                if (widget.filters.length != index + 1)
                  Divider(
                    color: AppColor.dividerColor,
                    height: height16,
                    thickness: height02,
                  )
              ],
            );
          }),
    );

    return BottomSheetWidget(
        title: widget.title,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: height10,
          ),
          reasonsList,
          SizedBox(
            height: height20,
          ),
          toastWidget,
          SizedBox(
            height: height10,
          ),
          button
        ]));
  }
}

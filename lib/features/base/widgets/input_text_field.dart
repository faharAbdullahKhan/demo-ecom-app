import 'package:demo_ecommerce/features/base/style/color.dart';
import 'package:demo_ecommerce/features/base/style/dimension.dart';
import 'package:demo_ecommerce/features/base/style/style.dart';
import 'package:demo_ecommerce/features/base/widgets/label.dart';
import 'package:flutter/material.dart';

class InputTextField extends StatefulWidget {
  final FocusNode? focusNode;
  final bool readOnly;
  final String hintText;
  final String labelText;
  final TextInputType textInputType;
  final int? maxLength;
  final ValueChanged<String>? onValueChanged;
  final ValueChanged<String>? onSubmit;
  final TextEditingController? controller;
  final bool
  showErrorBorder; // legacy flag – if false, will force red border off
  final bool showCounter;
  final int maxLines;
  final TextInputAction textInputAction;
  final String errorText;

  const InputTextField({
    super.key,
    this.focusNode,
    this.readOnly = false,
    required this.hintText,
    this.textInputType = TextInputType.text,
    this.maxLength,
    this.onValueChanged,
    this.controller,
    this.showCounter = false,
    this.maxLines = 1,
    this.onSubmit,
    this.errorText = "",
    this.showErrorBorder = true,
    required this.labelText,
    this.textInputAction = TextInputAction.done,
  });

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  bool _isFocussed = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();

    _focusNode.addListener(() {
      setState(() => _isFocussed = _focusNode.hasFocus);
    });
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onChanged(String value) {
    widget.onValueChanged?.call(value);
  }

  Color _currentBorderColor(BuildContext context) {
    if (widget.showErrorBorder) return AppColor.error;

    return _isFocussed ? AppColor.textColor : AppColor.lineColor;
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = _currentBorderColor(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Label(widget.labelText, style: regularP2TextStyle),
        SizedBox(height: height05),
        TextFormField(
          focusNode: _focusNode,
          autovalidateMode: AutovalidateMode.disabled,
          onTapOutside: (event) => FocusScope.of(context).unfocus(),
          style: textFieldStyle.copyWith(fontWeight: FontWeight.w500),
          controller: widget.controller,
          keyboardType: widget.textInputType,
          textInputAction: widget.textInputAction,
          readOnly: widget.readOnly,
          enabled: !widget.readOnly,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          onChanged: _onChanged,
          onFieldSubmitted: (value) => widget.onSubmit?.call(value),
          decoration: InputDecoration(
            filled: true,
            hintText: widget.hintText,
            fillColor:
                widget.readOnly ? Colors.transparent : Colors.transparent,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            labelStyle: regularP2TextStyle.copyWith(color: AppColor.hintColor),
            hintStyle: regularP2TextStyle.copyWith(color: AppColor.hintColor),
            errorText: null,
            errorStyle: const TextStyle(height: 0),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius10),
              borderSide: BorderSide(color: borderColor, width: 1.2),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius10),
              borderSide: BorderSide(color: borderColor, width: 1.5),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius10),
              borderSide: BorderSide(color: AppColor.lineColor, width: 1.0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius10),
              borderSide: BorderSide(color: AppColor.error, width: 1.2),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(borderRadius10),
              borderSide: BorderSide(color: AppColor.error, width: 1.5),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: height16,
              horizontal: width12,
            ),
          ),
        ),
      ],
    );
  }
}

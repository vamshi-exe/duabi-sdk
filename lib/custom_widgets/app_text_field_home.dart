import 'package:dubai_sdk_kotlin/style/app_colors.dart';
import 'package:dubai_sdk_kotlin/style/font.dart';
import 'package:flutter/material.dart';

class AppTextFieldHome extends StatelessWidget {
  const AppTextFieldHome(
      {
       required this.hintText,
      this.suffix,
      this.key,
      required this.controller,
     required this.textInputType,
      this.filled = true,
      this.style,
      this.textAlign = TextAlign.start,
      this.fillColor,
      this.borderSide = const BorderSide(color: AppColors.white),
      this.errorBorderSide = const BorderSide(color: Colors.red),
      this.borderRadius = 1.0,
      this.focusNode,
      this.onChanged,
      this.errorText,
      this.validator, this.prefix});
  final Widget? suffix;
  final String hintText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final Function(String)? validator;
  final Key? key;
  final TextStyle? style;
  final TextAlign textAlign;
  final Color? fillColor;
  final bool filled;
  final BorderSide borderSide;
  final double borderRadius;
  final Function(String)? onChanged;
  final FocusNode? focusNode;
  final String? errorText;
  final BorderSide errorBorderSide;
  final Widget? prefix;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: key,
      child: TextFormField(
        style: style ??
            TextStyle(
                color: AppColors.blackLight.withOpacity(.8),
                fontSize: FontSize.title),
        controller: controller,
       // validator: validator,
        keyboardType: textInputType,
        textAlign: textAlign,
        focusNode: focusNode,
        cursorWidth: 1.40,
        cursorHeight: 20.0,
        onChanged: onChanged == null?null:(e) => onChanged!(e),
        decoration: InputDecoration(
            fillColor: fillColor,
            filled: filled,
            // hintText: hintText,
            labelText: hintText,
            suffixIcon: suffix,
            hintStyle: TextStyle(
              color: AppColors.grey400,
              fontSize: FontSize.subtitle,
            ),
            prefix: prefix,
            errorText: errorText,
            contentPadding: const EdgeInsets.only(left: 10.0),
            errorBorder: OutlineInputBorder(
              borderSide: errorBorderSide,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: errorBorderSide,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: borderSide,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: AppColors.grey200))),
      ),
    );
  }
}

import 'package:dubai_sdk_kotlin/style/app_colors.dart';
import 'package:dubai_sdk_kotlin/style/font.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextField extends StatelessWidget {
  const AppTextField(
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
      this.borderRadius = 1.0,
      this.focusNode,
      this.onChanged,
      this.obsecureText = false,
      this.maxLength,
      this.validator});
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
  final int? maxLength;
  final bool obsecureText;
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
        obscureText: obsecureText,
        focusNode: focusNode,
        cursorWidth: 1.40,
        cursorHeight: 20.0,
        maxLength: maxLength,
        onChanged: (e) => onChanged!(e),
        decoration: InputDecoration(
            fillColor: fillColor,
            filled: filled,
            hintText: hintText,
            counterText: "",
            suffixIcon: suffix,
            hintStyle: TextStyle(
              color: AppColors.grey400,
              fontSize: FontSize.subtitle,
            ),
            contentPadding: const EdgeInsets.only(left: 10.0),
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

import 'package:dubai_sdk_kotlin/style/app_colors.dart';
import 'package:dubai_sdk_kotlin/style/font.dart';
import 'package:dubai_sdk_kotlin/style/spacing.dart';
import 'package:flutter/material.dart';

enum ButtonType { fill, border }

class AppButton extends StatelessWidget {
  const AppButton({
    required this.text,
    Key? key,
    this.style,
    this.borderColor = AppColors.primary,
    this.shadow = false,
    this.icon,
    this.borderWidth = 1.50,
    this.fillColor,
    this.borderRadius = Dimensions.mediumRadius,
    this.buttonType = ButtonType.fill,
    required this.color,
    required this.textColor,
    this.onTap,
  }) : super(key: key);
  final String text;
  final VoidCallback? onTap;
  final TextStyle? style;
  final ButtonType buttonType;
  final Widget? icon;
  final double borderRadius;
  final bool shadow;
  final Color? fillColor;
  final Color borderColor;
  final double borderWidth;
  final Color color;
  final Color textColor;
  Decoration get _decoration {
    List<BoxShadow> boxShadow;
    if (shadow)
      boxShadow = [
        BoxShadow(
          color: Colors.grey.shade500,
          offset: Offset(0.0, 1.5),
          blurRadius: 1.0,
        ),
      ];
    else {
      boxShadow = <BoxShadow>[];
    }
    var dec;
    switch (buttonType) {
      case ButtonType.fill:
        dec = BoxDecoration(
          color: fillColor ?? AppColors.redAccent,
          boxShadow: boxShadow,
          borderRadius: BorderRadius.circular(borderRadius),
        );
        break;
      case ButtonType.border:
        dec = BoxDecoration(
          color: AppColors.white,
          boxShadow: boxShadow,
          border: Border.all(color: borderColor, width: borderWidth),
          borderRadius: BorderRadius.circular(borderRadius),
        );
        break;
      default:
        dec = BoxDecoration();
    }
    return dec;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Material(
          elevation: 2,
          color: color,
          borderRadius: BorderRadius.circular(borderRadius),
          child: InkWell(
            onTap: onTap,
            child: Center(
                child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon ?? Container(),
                Text(
                  text,
                  style: style ??
                      TextStyle(
                        fontSize: FontSize.normal,
                        color: textColor,
                      ),
                ),
              ],
            )),
          ),
        ),
        decoration: _decoration);
  }
}

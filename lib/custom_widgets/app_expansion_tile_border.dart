import 'package:dubai_sdk_kotlin/resources/images/images.dart';
import 'package:dubai_sdk_kotlin/resources/strings/app_strings.dart';
import 'package:dubai_sdk_kotlin/style/app_colors.dart';
import 'package:dubai_sdk_kotlin/style/spacing.dart';
import 'package:flutter/material.dart';

class AppExpansionTile extends StatelessWidget {
  final Widget child;
  final Color color;
  final Color textColor;
  final IconData icon;
  final String text;
  final String leadingImage;
  final bool isExpand;

  final Function() onTap;
  const AppExpansionTile(
      {Key? key,
     required this.child,
     required this.color,
     required this.textColor,
     required this.onTap,
     required this.icon,
     required this.text,
     required this.leadingImage, required this.isExpand})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: color,
          border: Border.all(color: color, width: 1.0),
          borderRadius: BorderRadius.circular(1.0)),
      margin: const EdgeInsets.symmetric(vertical: Spacing.halfSmallMargin),
      child: Column(
        children: [
          ListTile(
            title: Text(text,
                style: TextStyle(
                  color: textColor,
                )),
            onTap: onTap,
            leading: Container(
                height: 30.0, width: 30.0, child: Image.asset(leadingImage)),
            trailing: Icon(icon,color: textColor,),
          ),
         isExpand? child:Container()
        ],
      ),
    );
  }
}

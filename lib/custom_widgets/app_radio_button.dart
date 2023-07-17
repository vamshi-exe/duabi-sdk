import 'package:flutter/material.dart';

class AppRadioButton extends StatelessWidget {
  const AppRadioButton({
    Key? key,
    required this.value,
    required this.groupValue,
    required this.title,
    required this.onChange,
  }) : super(key: key);

  final int value;
  final int groupValue;
  final String title;
  final Function(int?) onChange;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
            value: value,
            groupValue: groupValue,
            visualDensity: VisualDensity.compact,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onChanged: onChange),
        InkWell(
            onTap: () {
              onChange(value);
            },
            child: Text("$title"))
      ],
    );
  }
}

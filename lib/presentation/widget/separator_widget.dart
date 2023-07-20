import 'package:flutter/material.dart';

class SeparatorWidget extends StatelessWidget {
  final String text;
  final double thickness;
  final double fontSize;
  final Color color;

  const SeparatorWidget({
    Key? key,
    required this.text,
    this.thickness = 1.0,
    this.fontSize = 16.0,
    this.color = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          child: Divider(
            color: color,
            thickness: thickness,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            text,
            style: TextStyle(fontSize: fontSize, color: color),
          ),
        ),
        Expanded(
          child: Divider(
            color: color,
            thickness: thickness,
          ),
        ),
      ],
    );
  }
}

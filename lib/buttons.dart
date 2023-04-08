import 'package:flutter/material.dart';

class AppButtons extends StatelessWidget {
  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
  final String text;
  IconData? icon;
  double size;

  AppButtons({Key? key,
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
    required this.text,
    required this.size,
    this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: borderColor,
            width: 1.0,
          )
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color colorText;
  /*cor brown(primaryColor) */
  CustomText(this.text,
      {this.style, this.colorText = const Color.fromRGBO(87, 42, 30, 1)});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style!.copyWith(color: colorText),
    );
  }
}

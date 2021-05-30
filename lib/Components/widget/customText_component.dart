import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color colorText;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final EdgeInsets padding;
  /*cor brown(primaryColor) */
  CustomText(
    this.text, {
    this.style,
    this.colorText = const Color.fromRGBO(87, 42, 30, 1),
    this.textAlign = TextAlign.center,
    this.maxLines,
    this.overflow,
    this.padding = const EdgeInsets.all(8.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Text(
        text,
        maxLines: maxLines,
        overflow: overflow,
        textAlign: textAlign,
        style: style == null
            ? Theme.of(context).textTheme.caption!.copyWith(color: colorText)
            : style!.copyWith(color: colorText),
      ),
    );
  }
}

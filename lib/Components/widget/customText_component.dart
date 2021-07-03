/// Widget responsável por padronizar a exibição do texto.
///
/// {@category Component}
/// {@subCategory Widget}
// ignore: library_names
library CustomText;

import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final Color colorText;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final EdgeInsets padding;
  final bool isSelectable;
  /*cor brown(primaryColor) */
  CustomText(
    this.text, {
    this.style,
    this.colorText = const Color.fromRGBO(87, 42, 30, 1),
    this.textAlign = TextAlign.center,
    this.maxLines,
    this.overflow,
    this.padding = const EdgeInsets.all(8.0),
    this.isSelectable=true,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: isSelectable?SelectableText(
        text,
        maxLines: maxLines,
        textAlign: textAlign,
        style: style == null
            ? Theme.of(context).textTheme.caption!.copyWith(color: colorText)
            : style!.copyWith(color: colorText),
      ):Text(
        text,
        maxLines: maxLines,
        textAlign: textAlign,
        style: style == null
            ? Theme.of(context).textTheme.caption!.copyWith(color: colorText)
            : style!.copyWith(color: colorText),
        overflow: overflow,
      ),
    );
  }
}

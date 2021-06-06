/// Widget responsável por padronizar a exibição do botão.
///
/// {@category Component}
/// {@subCategory Widget}
// ignore: library_names
library CustomButton;

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final EdgeInsets paddingButton;
  final EdgeInsets paddingText;
  final bool expandButton;
  final FocusNode? focusNode;
  final ButtonStyle? style;
  final String loadingText;
  final bool isLoading;

  CustomButton({
    required this.text,
    required this.onPressed,
    this.paddingButton = const EdgeInsets.all(16.0),
    this.paddingText = const EdgeInsets.all(4.0),
    this.expandButton = false,
    this.focusNode,
    this.style,
    this.loadingText = "",
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: paddingButton,
        child: ElevatedButton(
          onPressed: isLoading ? null : onPressed,
          style: isLoading
              ? ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Theme.of(context).primaryColor.withAlpha(170)),
                )
              : style == null
                  ? Theme.of(context).elevatedButtonTheme.style
                  : style,
          child: Padding(
            padding: paddingText,
            child: expandButton
                ? Center(
                    child: Text(
                        isLoading
                            ? loadingText.toUpperCase()
                            : text.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.button!))
                : Text(
                    isLoading ? loadingText.toUpperCase() : text.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.button!),
          ),
        ));
  }
}

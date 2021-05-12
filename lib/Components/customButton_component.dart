import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  final EdgeInsets paddingButton;
  final EdgeInsets paddingText;
  final bool expandButton;
  final FocusNode? focusNode;
  final ButtonStyle? style;
  CustomButton({
    required this.text,
    required this.onPressed,
    this.paddingButton = const EdgeInsets.all(16.0),
    this.paddingText = const EdgeInsets.all(4.0),
    this.expandButton = false,
    this.focusNode,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: paddingButton,
        child: ElevatedButton(
          onPressed: onPressed,
          style: style == null
              ? Theme.of(context).elevatedButtonTheme.style
              : style,
          child: Padding(
            padding: paddingText,
            child: expandButton
                ? Center(
                    child: Text(text.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.button!))
                : Text(text.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.button!),
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextInputType textInputType;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final void Function(String?)? onFieldSubmitted;
  final void Function()? onEditingComplete;
  final obscureText;
  final String? initialValue;
  final int maxCharacters;
  final EdgeInsets padding;
  CustomTextFormField({
    required this.labelText,
    this.initialValue,
    this.controller,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.obscureText = false,
    this.validator,
    required this.hintText,
    required this.textInputType,
    this.onChanged,
    this.maxCharacters = 0,
    this.padding = const EdgeInsets.all(8.0),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextFormField(
          initialValue: initialValue,
          onEditingComplete: onEditingComplete,
          controller: controller,
          keyboardType: textInputType,
          obscureText: obscureText,
          onChanged: onChanged,
          validator: validator,
          onFieldSubmitted: onFieldSubmitted,
          textInputAction: TextInputAction.next,
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(color: Theme.of(context).primaryColor),
          decoration: InputDecoration(
            hintText: hintText,
            labelText: labelText,
            border: OutlineInputBorder(),
            labelStyle: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          inputFormatters: maxCharacters <= 0
              ? []
              : [
                  LengthLimitingTextInputFormatter(maxCharacters),
                ]),
    );
  }
}

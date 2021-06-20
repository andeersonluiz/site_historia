/// Widget responsável por padronizar a exibição do checkbox.
///
/// {@category Component}
/// {@subCategory Widget}
// ignore: library_names
library CustomCheckBox;

import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final String title;
  final bool value;
  final void Function(bool?) onChanged;

  CustomCheckBox(
      {required this.title, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(
          unselectedWidgetColor: Theme.of(context).primaryColor,
          focusColor: Colors.transparent,
          checkboxTheme: CheckboxThemeData(
            overlayColor: MaterialStateProperty.all<Color>(
              Colors.transparent,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Checkbox(
                value: value,
                activeColor: Theme.of(context).primaryColor,
                onChanged: onChanged,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: SelectableText(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .button!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
              ),
            ],
          ),
        ));
  }
}

import 'package:flutter/material.dart';

class CustomCheckBox extends StatelessWidget {
  final String title;
  final bool value;
  final ListTileControlAffinity controlAffinity;
  final void Function(bool?) onChanged;

  CustomCheckBox(
      {required this.title,
      required this.value,
      this.controlAffinity = ListTileControlAffinity.leading,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(unselectedWidgetColor: Theme.of(context).primaryColor),
        child: CheckboxListTile(
          title: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .button!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
          value: value,
          controlAffinity: controlAffinity,
          activeColor: Theme.of(context).primaryColor,
          selectedTileColor: Theme.of(context).primaryColor,
          onChanged: onChanged,
        ));
  }
}

/// Widget responsável por padronizar a exibição do dropdown.
///
/// {@category Component}
/// {@subCategory Widget}
// ignore: library_names
library CustomDropdown;

import 'package:flutter/material.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:site_historia/Components/widget/customText_component.dart';

class CustomDropdown extends StatelessWidget {
  final String value;
  final List<String> items;
  final Function(String?)? onChanged;

  CustomDropdown({
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1.0, style: BorderStyle.solid),
          borderRadius: BorderRadius.all(Radius.circular(5.0)),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: ButtonTheme(
          alignedDropdown: true,
          child: DropdownButton(
            isDense: false,
            items: items
                .map((value) => DropdownMenuItem(
                      value: value,
                      child: PointerInterceptor(
                          child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: ButtonTheme(
                            child: CustomText(value,
                                style: Theme.of(context).textTheme.caption)),
                      )),
                    ))
                .toList(),
            onChanged: onChanged,
            isExpanded: true,
            value: value,
          ),
        ),
      ),
    );
  }
}

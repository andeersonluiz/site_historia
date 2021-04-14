import 'package:flutter/material.dart';

class CustomDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor.withAlpha(50),
      width: MediaQuery.of(context).size.width,
      height: 1,
    );
  }
}

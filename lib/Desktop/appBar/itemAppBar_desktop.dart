import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:velocity_x/velocity_x.dart';

class ItemAppBarDesktop extends StatelessWidget {
  final String title;
  final String path;
  ItemAppBarDesktop(
    this.title,
    this.path,
  );
  @override
  Widget build(BuildContext context) {
    return HoverButton(
        hoverColor: Theme.of(context).hoverColor,
        shape: BeveledRectangleBorder(),
        padding: EdgeInsets.zero,
        hoverPadding: EdgeInsets.zero,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ),
        onpressed: () {
          Navigator.of(context).pop();
          VxNavigator.of(context).push(Uri.parse(path));
        });
  }
}

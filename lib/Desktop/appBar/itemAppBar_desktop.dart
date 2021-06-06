/// Widget responsável exibir um item no menu do site.
///
/// {@category Desktop}
/// {@subCategory Drawer}
// ignore: library_names
library ItemAppBarDesktop;
import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:velocity_x/velocity_x.dart';


class ItemAppBarDesktop extends StatelessWidget {
  /// Texto do item.
  final String title;
  /// Rota que é redirecionado quando o item é clicado.
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

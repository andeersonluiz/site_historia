/// Widget responsável por exibir o drawer da página do site.
///
/// {@category Mobile}
/// {@subCategory Drawer}
// ignore: library_names
library DrawerItemMobile;

import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:velocity_x/velocity_x.dart';

/// Padroniza a exibição de um item do drawer.
class DrawerItemMobile extends StatelessWidget {
  /// Ícone que é exibido antes do texto.
  final IconData icon;
  /// Rota que é redirecionado quando o item é clicado.
  final String path;
  /// Texto do item.
  final String title;

  DrawerItemMobile(this.title, this.path, this.icon);
  @override
  Widget build(BuildContext context) {
    return HoverButton(
        hoverColor: Theme.of(context).hoverColor,
        shape: BeveledRectangleBorder(),
        padding: EdgeInsets.zero,
        hoverPadding: EdgeInsets.zero,
        onpressed: () async {
          Scaffold.of(context).openEndDrawer();
          Navigator.of(context).pop();
          await VxNavigator.of(context).clearAndPush(Uri.parse(path));
        },
        child: ListTile(
          leading: Icon(icon, color: Theme.of(context).backgroundColor),
          title: Text(title),
        ));
  }
}

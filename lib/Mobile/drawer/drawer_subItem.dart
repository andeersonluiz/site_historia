/// Widget responsável por exibir um subitem no drawer da página do site.
///
/// {@category Mobile}
/// {@subCategory Drawer}
// ignore: library_names
library DrawerItemMobile;

import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:site_historia/Model/project_model.dart';
import 'package:velocity_x/velocity_x.dart';

/// Padroniza a exibição de um subitem do drawer (Utilizado em projetos e quadros).
class DrawerSubItemMobile extends StatelessWidget {
  /// Objeto que é utilizado para o envio do id no redirecionamento e a exibição do título.
  final dynamic object;
  /// Ícone que é exibido antes do texto.
  final IconData icon;
  /// Rota que é redirecionado quando o item é clicado.
  final String path;

  DrawerSubItemMobile(this.object, this.path, this.icon);
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
        VxNavigator.of(context).replace(
          Uri(path: path, queryParameters: {"id": object.id.toString()}),
          params: object,
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: ListTile(
          leading: Icon(icon, color: Theme.of(context).backgroundColor),
          title: Text(object is Project ? object.name : object.title),
        ),
      ),
    );
  }
}

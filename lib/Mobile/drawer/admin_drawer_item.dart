/// Widget responsável por exibir um item do drawer na página do Admin.
///
/// {@category Mobile}
/// {@subCategory Drawer}
// ignore: library_names
library AdminDrawerItemMobile;

import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:site_historia/Components/widget/customToast_component.dart';
import 'package:site_historia/firebase/login_auth.dart';
import 'package:velocity_x/velocity_x.dart';

/// Padroniza a exibição de um item do drawer.
class AdminDrawerItemMobile extends StatelessWidget {
  /// Icon que é exibido antes do texto.
  final IconData icon;
  /// Rota que é redirecionado quando o item é clicado.
  final String path;
  /// Texto do item.
  final String title;

  AdminDrawerItemMobile(this.title, this.path, this.icon);
  @override
  Widget build(BuildContext context) {
    return HoverButton(
        hoverColor: Theme.of(context).hoverColor,
        shape: BeveledRectangleBorder(),
        padding: EdgeInsets.zero,
        hoverPadding: EdgeInsets.zero,
        onpressed: () async {
          if (title == "Sair") {
            await LoginAuth.signOut();
            CustomToast.showToast("Você saiu com sucesso!", Colors.green);
          }
          FocusScope.of(context).requestFocus(FocusNode());
          VxNavigator.of(context).pop();

          await VxNavigator.of(context).push(Uri.parse(path));

          Scaffold.of(context).openEndDrawer();
        },
        child: ListTile(
          leading: Icon(icon, color: Theme.of(context).backgroundColor),
          title: Text(title),
        ));
  }
}

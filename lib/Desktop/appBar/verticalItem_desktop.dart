/// Widget responsável por um item do menu vertical na página do Admin.
///
/// {@category Desktop}
/// {@subCategory Drawer}
// ignore: library_names
library VerticalItemDesktop;

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:site_historia/Components/widget/customToast_component.dart';
import 'package:site_historia/firebase/login_auth.dart';
import 'package:velocity_x/velocity_x.dart';

/// Padroniza a exibição de um item do menu.
class VerticalItemDesktop extends StatelessWidget {
  /// Texto do item.
  final String title;
  /// Rota que é redirecionado quando o item é clicado.
  final String path;
  /// Icon que é exibido antes do texto.
  final IconData icon;
  /// Controle para verificar se é exibido apenas o ícone.
  final bool isMini;
  VerticalItemDesktop(this.title, this.path, this.icon, {this.isMini = false});
  @override
  Widget build(BuildContext context) {
    return HoverButton(
        hoverColor: Theme.of(context).hoverColor,
        shape: BeveledRectangleBorder(),
        padding: EdgeInsets.all(8),
        hoverPadding: EdgeInsets.zero,
        child: Center(
          child: Tooltip(
            message: title,
            height: 42,
            decoration: BoxDecoration(
                color: Theme.of(context).iconTheme.color,
                borderRadius: BorderRadius.circular(8.0)),
            textStyle: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(color: Theme.of(context).primaryColor),
            child: isMini == false
                ? ListTile(
                    leading:
                        Icon(icon, color: Theme.of(context).iconTheme.color),
                    title: AutoSizeText(
                      title,
                      minFontSize: 5,
                      maxFontSize: 16,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Icon(
                      icon,
                      color: Theme.of(context).iconTheme.color,
                      size: 24,
                    ),
                  ),
          ),
        ),
        onpressed: () async {
          if (title == "Sair") {
            await LoginAuth.signOut();
            CustomToast.showToast("Você saiu com sucesso!", Colors.green);
          }
          VxNavigator.of(context).pop();
          VxNavigator.of(context).push(Uri.parse(path));
        });
  }
}

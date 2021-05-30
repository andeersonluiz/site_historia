import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:site_historia/Components/widget/customToast_component.dart';
import 'package:site_historia/firebase/login_auth.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminDrawerItemMobile extends StatelessWidget {
  final IconData icon;
  final String path;
  final String title;
  final bool clearData;

  AdminDrawerItemMobile(this.title, this.path, this.icon, {this.clearData = false});
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

import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:velocity_x/velocity_x.dart';

class DrawerItemMobile extends StatelessWidget {
  final IconData icon;
  final String path;
  final String title;
  final bool clearData;

  DrawerItemMobile(this.title, this.path, this.icon, {this.clearData = false});
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

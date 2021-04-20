import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:velocity_x/velocity_x.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String path;
  final String title;

  DrawerItem(this.title, this.path, this.icon);
  @override
  Widget build(BuildContext context) {
    return HoverButton(
        hoverColor: Theme.of(context).hoverColor,
        shape: BeveledRectangleBorder(),
        padding: EdgeInsets.all(0),
        hoverPadding: EdgeInsets.all(0),
        onpressed: () {
          
          VxNavigator.of(context).replace(Uri.parse(path));
        },
        child: ListTile(
          leading: Icon(icon, color: Theme.of(context).backgroundColor),
          title: Text(title),
        ));
  }
}

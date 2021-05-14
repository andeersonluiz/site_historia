import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:site_historia/Model/project_model.dart';
import 'package:velocity_x/velocity_x.dart';

class DrawerSubItem extends StatelessWidget {
  final dynamic object;
  final IconData icon;
  final String path;

  DrawerSubItem(this.object, this.path, this.icon);
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

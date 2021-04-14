import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
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
      padding: EdgeInsets.all(0),
      hoverPadding: EdgeInsets.all(0),
      onpressed: () {
        print("objectId ${object.id.toString()}");
        VxNavigator.of(context)
            .push(Uri(path:path,queryParameters: {"id":object.id.toString()}),params: object);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: ListTile(
          leading: Icon(icon, color: Theme.of(context).backgroundColor),
          title: Text(object.name),
        ),
      ),
    );
  }
}

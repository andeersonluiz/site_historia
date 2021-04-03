import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';

class DrawerSubItem extends StatelessWidget {
  final IconData icon;
  final String title;

  DrawerSubItem(this.title, this.icon);
  @override
  Widget build(BuildContext context) {
    return HoverButton(
      hoverColor: Theme.of(context).hoverColor,
      shape: BeveledRectangleBorder(),
      padding: EdgeInsets.all(0),
      hoverPadding: EdgeInsets.all(0),
      onpressed: () {},
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: ListTile(
          leading: Icon(icon, color: Theme.of(context).backgroundColor),
          title: Text(title),
        ),
      ),
    );
  }
}

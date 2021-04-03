import 'package:flutter/material.dart';

class DrawerSubItem extends StatelessWidget {
  final IconData icon;
  final String title;

  DrawerSubItem(this.title, this.icon);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Theme.of(context).backgroundColor),
        title: Text(title),
      ),
    );
  }
}

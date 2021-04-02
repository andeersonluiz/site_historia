import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;

  DrawerItem(this.title, this.icon);
  @override
  Widget build(BuildContext context) {
    return  ListTile(
        leading: Icon(icon),
        title: Text(title),
      );
    
    
  }
}

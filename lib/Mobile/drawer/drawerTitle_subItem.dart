import 'package:flutter/material.dart';
import 'drawer_subItem.dart';

class DrawerItemWithSubItemMobile extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<DrawerSubItemMobile> children;

  DrawerItemWithSubItemMobile(
      {required this.title, required this.icon, required this.children});
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
        title: Text(title), leading: Icon(icon), children: children);
  }
}

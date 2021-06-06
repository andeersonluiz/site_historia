/// Widget responsável por montar a lista com o subitens no drawer da página do site.
///
/// {@category Mobile}
/// {@subCategory Drawer}
// ignore: library_names
library DrawerItemWithSubItemMobile;

import 'package:flutter/material.dart';
import 'drawer_subItem.dart';

/// Faz a montagem de um lista de subitens do drawer (Utilizado em projetos e quadros).
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

import 'package:flutter/material.dart';

class IconButtonFooter extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;
  IconButtonFooter(this.icon, this.onPressed);
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
        onPressed: onPressed,
        shape: CircleBorder(),
        child: Icon(
          icon,
          color: Theme.of(context).primaryColor,
        ),
        fillColor: Colors.white);
  }
}

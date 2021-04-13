import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:site_historia/Route/fluroRouter.dart';

class ItemAppBar extends StatelessWidget {
  final String title;
  final String path;
  final Function function;

  ItemAppBar(this.title, this.path, this.function);
  @override
  Widget build(BuildContext context) {
    return HoverButton(
        hoverColor: Theme.of(context).hoverColor,
        shape: BeveledRectangleBorder(),
        padding: EdgeInsets.all(0),
        hoverPadding: EdgeInsets.all(0),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ),
        onpressed: () => FluroRouting.router
            .navigateTo(context, path, transition: TransitionType.fadeIn));
  }
}

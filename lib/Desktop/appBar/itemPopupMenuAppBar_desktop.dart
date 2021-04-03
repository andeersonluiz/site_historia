import 'package:flutter/material.dart';

class ItemPopUpMenuAppBar extends StatefulWidget {
  final String name;
  final List<String> listItems;
  ItemPopUpMenuAppBar(this.name, this.listItems);

  @override
  _ItemPopUpMenuAppBarState createState() => _ItemPopUpMenuAppBarState();
}

class _ItemPopUpMenuAppBarState extends State<ItemPopUpMenuAppBar>
    with SingleTickerProviderStateMixin {
  late AnimationController rotationController;

  @override
  void initState() {
    super.initState();
    rotationController = AnimationController(
        duration: const Duration(milliseconds: 200), vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Theme.of(context).primaryColor,
      itemBuilder: (ctx) => widget.listItems.map((e) {
        if (widget.listItems.first == e) {
          rotationController.forward();
        }
        return PopupMenuItem(child: Text(e));
      }).toList(),
      onCanceled: () {
        rotationController.animateBack(0.0);
      },
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child:
              Text(widget.name, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        RotationTransition(
            turns: Tween(begin: 0.0, end: 0.5).animate(rotationController),
            child: Icon(
              Icons.keyboard_arrow_down_rounded,
            ))
      ]),
      elevation: 8,
      offset: Offset(0, 45),
    );
  }
}

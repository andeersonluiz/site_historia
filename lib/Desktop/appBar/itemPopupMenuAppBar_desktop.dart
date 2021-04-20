import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:velocity_x/velocity_x.dart';

class ItemPopUpMenuAppBar extends StatefulWidget {
  final String name;
  final String path;
  final List<dynamic> listItems;
  ItemPopUpMenuAppBar(this.name, this.path, this.listItems);

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
    return HoverButton(
      hoverColor: Theme.of(context).hoverColor,
      shape: BeveledRectangleBorder(),
      padding: EdgeInsets.all(0),
      hoverPadding: EdgeInsets.all(0),
      onpressed: () {},
      child: Container(
        height: double.infinity,
        child: PopupMenuButton(
          onSelected: (result) {
            int index = result as int;
            rotationController.animateBack(0.0);
            VxNavigator.of(context).push(
                Uri(path: widget.path, queryParameters: {
                  "id": widget.listItems[index].id.toString()
                }),
                params: widget.listItems[index]);
          },
          color: Theme.of(context).primaryColor,
          itemBuilder: (ctx) => widget.listItems.map((item) {
            if (widget.listItems.first == item) {
              rotationController.forward();
            }
            return PopupMenuItem(
                value: item.id,
                child: Text(item.name,
                    style: Theme.of(context).textTheme.bodyText1));
          }).toList(),
          onCanceled: () {
            rotationController.animateBack(0.0);
          },
          child: Row(children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(widget.name,
                  style: Theme.of(context).textTheme.bodyText1),
            ),
            RotationTransition(
                turns: Tween(begin: 0.0, end: 0.5).animate(rotationController),
                child: Icon(Icons.keyboard_arrow_down_rounded,
                    color: Theme.of(context).iconTheme.color))
          ]),
          elevation: 8,
          offset: Offset(0, 69),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import 'package:site_historia/Model/project_model.dart';
import 'package:velocity_x/velocity_x.dart';

class ItemPopUpMenuAppBarDesktop extends StatefulWidget {
  final String name;
  final String path;
  final List<dynamic> listItems;
  ItemPopUpMenuAppBarDesktop(this.name, this.path, this.listItems);

  @override
  _ItemPopUpMenuAppBarDesktopState createState() => _ItemPopUpMenuAppBarDesktopState();
}

class _ItemPopUpMenuAppBarDesktopState extends State<ItemPopUpMenuAppBarDesktop>
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
      padding: EdgeInsets.zero,
      hoverPadding: EdgeInsets.zero,
      onpressed: () {},
      child: Container(
        height: double.infinity,
        child: PopupMenuButton(
          onSelected: (result) {
            int index = result as int;
            rotationController.animateBack(0.0);
            Navigator.of(context).pop();

            VxNavigator.of(context).push(Uri(
                path: widget.path, queryParameters: {"id": index.toString()}));
          },
          color: Theme.of(context).primaryColor,
          itemBuilder: (ctx) => widget.listItems.map((item) {
            if (widget.listItems.first == item) {
              rotationController.forward();
            }
            return PopupMenuItem(
                value: item.id,
                child: Text(item is Project ? item.name : item.title,
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
          offset: Offset(0, 59),
        ),
      ),
    );
  }
}

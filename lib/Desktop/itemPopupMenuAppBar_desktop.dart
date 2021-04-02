import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Store/support_store.dart';

class ItemPopUpMenuAppBar extends StatelessWidget {
  final String name;
  final List<String> listItems;
  ItemPopUpMenuAppBar(this.name, this.listItems);
  @override
  Widget build(BuildContext context) {
    final supportStore = Provider.of<SupportStore>(context);
    return Observer(builder: (context) {
      return PopupMenuButton(
        color: Theme.of(context).primaryColor,
        itemBuilder: (ctx) => listItems.map((e) {
          if (listItems.first == e) {
            supportStore.updateOpen(name);
          }
          return PopupMenuItem(child: Text(e));
        }).toList(),
        onCanceled: () {
          supportStore.updateOpen(name);
        },
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          (name == "Projetos"
                  ? supportStore.openProject
                  : supportStore.openQuads)
              ? Icon(
                  Icons.keyboard_arrow_up_rounded,
                )
              : Icon(Icons.keyboard_arrow_down_rounded),
        ]),
        elevation: 8,
        offset: Offset(0, 45),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Store/notice_store.dart';

class SearchBar extends StatelessWidget {
  final width;
  SearchBar({required this.width});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final noticeStore = Provider.of<NoticeStore>(context);
    return Container(
      width: width,
      margin: EdgeInsets.all(8.0),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 0,
        title: TextField(
          controller: controller,
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(color: Theme.of(context).primaryColor),
          decoration: InputDecoration(
            labelStyle: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(color: Theme.of(context).primaryColor),
            hintText: 'Digite para pesquisar...',
            contentPadding: EdgeInsets.only(left: 16, bottom: 28.0),
          ),
        ),
        trailing: IconButton(
          padding: EdgeInsets.only(bottom: 28.0),
          splashRadius: 25.0,
          color: Theme.of(context).primaryColor,
          icon: Icon(Icons.search),
          onPressed: () {
            noticeStore.search(controller.text);
            noticeStore.updateMenuBar("");
          },
        ),
      ),
    );
  }
}

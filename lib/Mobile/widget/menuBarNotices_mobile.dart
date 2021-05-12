import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/utils/shims/dart_ui_real.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/searchBar_component.dart';
import 'package:site_historia/Store/notice_store.dart';
import 'package:site_historia/Support/globals_variables.dart';

class MenuBarNoticesMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final noticeStore = Provider.of<NoticeStore>(context);
    return Container(
        decoration: ShapeDecoration(
          color: Theme.of(context).primaryColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        ),
        margin: EdgeInsets.all(16.0),
        height: 50,
        width: MediaQuery.of(context).size.width,
        child: Row(children: [
          SearchBar(
            width: 200,
          ),
          Spacer(),
          Container(
            child: PopupMenuButton<String>(
              itemBuilder: (_) => GlobalsVariables.filters
                  .map(
                    (value) => PopupMenuItem(
                      value: value,
                      child: Text(
                        value,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  )
                  .toList(),
              onSelected: (value) {
                noticeStore.updateMenuBar(value);
                noticeStore.filterListNotices(value);
              },
              icon: Icon(Icons.library_add),
              offset: Offset(0, 39),
            ),
          ),
        ]));
  }
}

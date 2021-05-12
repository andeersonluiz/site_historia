import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:html_editor_enhanced/utils/shims/dart_ui_real.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/searchBar_component.dart';
import 'package:site_historia/Store/notice_store.dart';
import 'package:site_historia/Support/globals_variables.dart';

class MenuBarNotices extends StatelessWidget {
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
        Observer(
          builder: (_) => Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: GlobalsVariables.filters
                  .map((value) => ElevatedButton(
                      style: value == GlobalsVariables.filters[0]
                          ? ButtonStyle(
                              backgroundColor: noticeStore.barSelected == value
                                  ? MaterialStateProperty.all(
                                      Theme.of(context).hoverColor)
                                  : null,
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(20.0)))),
                            )
                          : ButtonStyle(
                              backgroundColor: noticeStore.barSelected == value
                                  ? MaterialStateProperty.all(
                                      Theme.of(context).hoverColor)
                                  : null,
                            ),
                      child: Text(value),
                      onPressed: () {
                        if (value != noticeStore.barSelected) {
                          noticeStore.updateMenuBar(value);
                          noticeStore.filterListNotices(value);
                          FocusScope.of(context).requestFocus(FocusNode());
                        }
                      }))
                  .toList()),
        ),
        Spacer(),
        SearchBar(
          width: 200,
        )
      ]),
    );
  }
}

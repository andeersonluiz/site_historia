/// Widget responsável por exibir a lista de notícias na página ´notice_page`.
///
/// {@category Component}
/// {@subCategory Widget}
// ignore: library_names
library ListNotices;

import 'package:flutter/material.dart';
import 'package:site_historia/Components/tile/noticeTile_desktop.dart';
import 'package:site_historia/Model/notice_model.dart';

/// Exibe uma lista de notícias utilizando o widget `NoticeTile(Notice noticia)`.
class ListNotices extends StatelessWidget {
  final List<Notice> notices;
  ListNotices(this.notices);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: notices.map((notice) {
        return Column(
          children: [
            NoticeTile(notice),
            notices.last == notice
                ? Container()
                : Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Divider(
                      height: 8.0,
                      thickness: 1.0,
                      color: Theme.of(context).primaryColor.withAlpha(80),
                    ),
                  )
          ],
        );
      }).toList(),
    );
  }
}

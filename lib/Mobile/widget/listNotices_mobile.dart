/// Widget responsável por exibir a lista de notícias na página ´notice_page` (versão mobile).
///
/// {@category Desktop}
/// {@subCategory Widget}
// ignore: library_names
library ListNoticesMobile;

import 'package:flutter/material.dart';
import 'package:site_historia/Mobile/tile/noticeTile_mobile.dart';
import 'package:site_historia/Model/notice_model.dart';

/// Exibe uma lista de notícias utilizando o widget `NoticeTileMobile(Notice noticia)`.
class ListNoticesMobile extends StatelessWidget {
  final List<Notice> notices;
  ListNoticesMobile(this.notices);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: notices.map((notice) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: NoticeTileMobile(notice),
            ),
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

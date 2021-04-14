import 'package:flutter/material.dart';
import 'package:site_historia/Components/customLoading_component.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';

import '../../firebase/notice_firestore.dart';
import '../../model/notice_model.dart';
import '../tile/postTile_desktop.dart';

class LatestPosts extends StatelessWidget {
  final noticeFirestore = NoticeFirestore();
  @override
  Widget build(BuildContext context) {
    /**CONECTAR AO BD PARA CARREGAR ULTIMAS POSTAGENS DO SITE*/
    return FutureBuilder(
      future: noticeFirestore.getNotices(),
      builder: (ctx, snp) {
        if (snp.hasData) {
          List<Notice> listNotices = snp.data as List<Notice>;
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Ultimas Postagens",
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
              ),
              PostTile(listNotices[0]),
              PostTile(listNotices[1]),
              PostTile(listNotices[2]),
            ],
          );
        } else if (snp.hasError) {
          return ErrorLoad(color: Theme.of(context).primaryColor);
        } else {
          return CustomLoading();
        }
      },
    );
  }
}

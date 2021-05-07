import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/customLoading_component.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Store/notice_store.dart';

import '../../Model/notice_model.dart';
import '../tile/postTile_desktop.dart';

class LatestPosts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final noticeStore = Provider.of<NoticeStore>(context);

    return Observer(
      builder: (ctx) {
        noticeStore.listRecentNotices ?? noticeStore.getRecentNotices();

        switch (noticeStore.listRecentNotices!.status) {
          case FutureStatus.pending:
            return CustomLoading();

          case FutureStatus.rejected:
            return ErrorLoad(color: Theme.of(context).primaryColor);
          case FutureStatus.fulfilled:
            List<Notice> listNotices =
                noticeStore.listRecentNotices!.value as List<Notice>;
            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                for (var notice in listNotices) PostTile(notice),
              ],
            );
        }
      },
    );
  }
}

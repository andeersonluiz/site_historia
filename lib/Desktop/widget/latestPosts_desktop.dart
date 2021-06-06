/// Widget responsável por exibir os posts mais recentes na página inicial (versão desktop).
///
/// {@category Desktop}
/// {@subCategory Widget}
// ignore: library_names
library LatestPostsDesktop;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/widget/customLoading_component.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Store/notice_store.dart';
import 'package:site_historia/Support/routesName_support.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../Model/notice_model.dart';
import '../tile/postTile_desktop.dart';

/// Carrega todas as notícias através do método `getRecentNotices()` que filtra as notícias com o valor `type=Noticia`.
/// Utiliza o widget `PostTileDesktop()´ para montar um Container com as informações do post.
class LatestPostsDesktop extends StatelessWidget {
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
                for (var notice in listNotices)
                  InkWell(
                      onTap: () {
                        VxNavigator.of(context).push(Uri(
                            path: RouteNames.NOTICES,
                            queryParameters: {"id": notice.id.toString()}));
                      },
                      child: PostTileDesktop(notice)),
              ],
            );
        }
      },
    );
  }
}

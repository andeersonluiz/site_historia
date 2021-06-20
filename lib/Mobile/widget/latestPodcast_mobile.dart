/// Widget responsável por exibir os podcasts mais recentes na página inicial (versão mobile).
///
/// {@category Mobile}
/// {@subCategory Widget}
// ignore: library_names
library LatestPodcastMobile;

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
import '../tile/podcastTile_mobile.dart';

/// Carrega todas as notícias através do método `getRecentPodcasts()` que filtra as notícias com o valor `type=Podcast`.
/// Utiliza o widget `PodcastTileMobile()´ para montar um Container com as informações de podcast.
class LatestPodcastMobile extends StatelessWidget {
  final widthPercentageSize;
  LatestPodcastMobile({required this.widthPercentageSize});

  @override
  Widget build(BuildContext context) {
    final noticeStore = Provider.of<NoticeStore>(context);
    return Observer(
      builder: (ctx) {
        noticeStore.listRecentPodcast ?? noticeStore.getRecentPodcasts();
        switch (noticeStore.listRecentPodcast!.status) {
          case FutureStatus.pending:
            return CustomLoading();

          case FutureStatus.rejected:
            return ErrorLoad(color: Theme.of(context).primaryColor);
          case FutureStatus.fulfilled:
            List<Notice> listNotices =
                noticeStore.listRecentPodcast!.value as List<Notice>;
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SelectableText(
                    "Últimos Podcasts",
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
                      child: PodcastTileMobile(notice, widthPercentageSize)),
              ],
            );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/customLoading_component.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Store/notice_store.dart';
import 'package:site_historia/Support/RoutesName_support.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../Model/notice_model.dart';
import '../tile/podcastTile_mobile.dart';

class LatestPodcastMobile extends StatelessWidget {
  final widthPercentualSize;
  LatestPodcastMobile({required this.widthPercentualSize});

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
                  child: Text(
                    "Ultimos Podcasts",
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
                      child: PodcastTileMobile(notice, widthPercentualSize)),
              ],
            );
        }
      },
    );
  }
}

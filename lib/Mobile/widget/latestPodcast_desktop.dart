import 'package:flutter/material.dart';

import '../../Desktop/tile/podcastTile_desktop.dart';
import '../../firebase/notice_firestore.dart';
import '../../model/notice_model.dart';

class LatestPodcast extends StatelessWidget {
  final noticeFirestore = NoticeFirestore();
  @override
  Widget build(BuildContext context) {
    /**CONECTAR AO BD PARA CARREGAR ULTIMOS PODCAST DO SITE*/

    return FutureBuilder(
      future: noticeFirestore.getPodcasts(),
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
                  "Ultimos Podcasts",
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
              ),
              PodcastTile(listNotices[0]),
              PodcastTile(listNotices[1]),
              PodcastTile(listNotices[2]),
            ],
          );
        } else if (snp.hasError) {
          return Container();
        } else {
          return Container(
              child: Center(
                  child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).primaryColor)));
        }
      },
    );
  }
}

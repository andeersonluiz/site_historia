import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../firebase/notice_firestore.dart';
import '../../model/notice_model.dart';
import '../tile/podcastTile_desktop.dart';

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
                  style: GoogleFonts.roboto(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.15,
                      color: Theme.of(context).primaryColor),
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

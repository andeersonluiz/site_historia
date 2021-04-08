import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:site_historia/Desktop/tile/postTile_desktop.dart';
import 'package:site_historia/firebase/notice_firestore.dart';
import 'package:site_historia/model/notice_model.dart';

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
                  style: GoogleFonts.roboto(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.15,
                      color: Theme.of(context).primaryColor),
                ),
              ),
              PostTile(listNotices[0]),
              PostTile(listNotices[1]),
              PostTile(listNotices[2]),
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

import 'package:flutter/material.dart';
import '../../firebase/notice_firestore.dart';
import '../../model/notice_model.dart';
import '../tile/postTile_mobile.dart';

class LatestPostsMobile extends StatelessWidget {
  final noticeFirestore = NoticeFirestore();
  final widthPercentual;
  LatestPostsMobile(this.widthPercentual);
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
              PostTileMobile(listNotices[0], widthPercentual),
              PostTileMobile(listNotices[1], widthPercentual),
              PostTileMobile(listNotices[2], widthPercentual),
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

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/customLoading_component.dart';
import 'package:site_historia/Components/customText_component.dart';
import 'package:site_historia/Desktop/widget/listNotices_desktop.dart';
import 'package:site_historia/Mobile/widget/menuBarNotices_mobile.dart';
import 'package:site_historia/Model/notice_model.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Store/notice_store.dart';

class NoticePageMobile extends StatefulWidget {
  @override
  _NoticePageMobileState createState() => _NoticePageMobileState();
}

class _NoticePageMobileState extends State<NoticePageMobile> {
  NoticeStore? noticeStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    noticeStore = Provider.of<NoticeStore>(context);
    noticeStore!.getNotices();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomText("Noticias",
            style: Theme.of(context).textTheme.headline4),
      ),
      Divider(
        thickness: 1.0,
      ),
      MenuBarNoticesMobile(),
      Observer(builder: (_) {
        switch (noticeStore!.listNoticesFiltered!.status) {
          case FutureStatus.pending:
            return CustomLoading();
          case FutureStatus.rejected:
            return ErrorLoad(color: Theme.of(context).primaryColor);
          case FutureStatus.fulfilled:
            List<Notice> listNotice =
                noticeStore!.listNoticesFiltered!.value as List<Notice>;
            return ListNotices(listNotice);
        }
      }),
    ]);
  }
}

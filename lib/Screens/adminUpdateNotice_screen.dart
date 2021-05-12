import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Components/customLoading_component.dart';
import 'package:site_historia/Desktop/adminUpdateNotice_page_desktop.dart';
import 'package:site_historia/Desktop/appBar/verticalAppBar_desktop.dart';
import 'package:site_historia/Mobile/drawer/adminNavigation_drawer_component.dart';
import 'package:site_historia/Model/notice_model.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Screens/loading_screen.dart';
import 'package:site_historia/Store/notice_store.dart';
import 'package:site_historia/Support/RoutesName_support.dart';

class AdminUpdateNoticeScreen extends StatefulWidget {
  final String idNotice;

  AdminUpdateNoticeScreen(this.idNotice);

  @override
  _AdminUpdateNoticeScreenState createState() =>
      _AdminUpdateNoticeScreenState();
}

class _AdminUpdateNoticeScreenState extends State<AdminUpdateNoticeScreen> {
  @override
  Widget build(BuildContext context) {
    final noticeStore = Provider.of<NoticeStore>(context);

    return ResponsiveBuilder(
      builder: (ctx, sizingInformation) => Scaffold(
          drawer: sizingInformation.isDesktop ? null : AdminNavigatorDrawer(),
          appBar: sizingInformation.isDesktop ? null : AppBar(),
          body: Observer(
            builder: (_) {
              noticeStore.listNotices ?? noticeStore.getNotices();
              switch (noticeStore.listNotices!.status) {
                case FutureStatus.pending:
                  return Loading();
                case FutureStatus.rejected:
                  return ErrorLoad(color: Theme.of(context).primaryColor);
                case FutureStatus.fulfilled:
                  return FutureBuilder(
                    future: loadData(),
                    builder: (ctx, snp) {
                      if (snp.hasData) {
                        Notice notice = snp.data as Notice;
                        return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: ScreenTypeLayout(
                              mobile: AdminUpdateNoticePageDesktop(notice),
                              desktop: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: Row(children: [
                                  VerticalAppBar(),
                                  Expanded(
                                      child:
                                          AdminUpdateNoticePageDesktop(notice)),
                                ]),
                              )),
                        );
                      } else if (snp.hasError) {
                        return Loading(
                          redirect: true,
                          to: RouteNames.ADMIN_NOTICES,
                        );
                      } else {
                        return CustomLoading();
                      }
                    },
                  );
              }
            },
          )),
    );
  }

  loadData() async {
    final noticeStore = Provider.of<NoticeStore>(context);
    return await noticeStore.getNoticeById(widget.idNotice);
  }
}

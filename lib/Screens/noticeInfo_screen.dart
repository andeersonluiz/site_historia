import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Components/customLoading_component.dart';
import 'package:site_historia/Desktop/appBar/custtomAppBar_desktop.dart';
import 'package:site_historia/Desktop/noticeInfo_page_desktop.dart';
import 'package:site_historia/Mobile/noticeInfo_page_mobile.dart';
import 'package:site_historia/Model/notice_model.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Screens/loading_screen.dart';
import 'package:site_historia/Store/notice_store.dart';
import 'package:site_historia/Support/RoutesName_support.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:velocity_x/velocity_x.dart';
import '../Mobile/drawer/navigation_drawer_component.dart';

class NoticeInfoScreen extends StatefulWidget {
  final id;
  NoticeInfoScreen(this.id);
  @override
  _NoticeInfoScreenState createState() => _NoticeInfoScreenState();
}

class _NoticeInfoScreenState extends State<NoticeInfoScreen> {
  @override
  Widget build(BuildContext context) {
    final noticeStore = Provider.of<NoticeStore>(context);

    return Observer(
      builder: (_) {
        noticeStore.listNotices ?? noticeStore.getNotices();
        switch (noticeStore.listNotices!.status) {
          case FutureStatus.pending:
            return Loading();
          case FutureStatus.rejected:
            return ErrorLoad(
              color: Theme.of(context).primaryColor,
            );
          case FutureStatus.fulfilled:
            return FutureBuilder(
                future: loadData(),
                builder: (ctx, snp) {
                  if (snp.hasData) {
                    Notice notice = snp.data as Notice;
                    return ResponsiveBuilder(
                      builder: (ctx, sizingInformation) => Scaffold(
                        endDrawer: sizingInformation.isDesktop
                            ? null
                            : NavigationDrawer(),
                        appBar: sizingInformation.isDesktop
                            ? null
                            : AppBar(
                                automaticallyImplyLeading: false,
                                actions: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16.0),
                                      child: IconButton(
                                        icon:
                                            Icon(Icons.arrow_back_ios_outlined),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          VxNavigator.of(context).push(
                                              Uri.parse(RouteNames.NOTICES));
                                        },
                                      ),
                                    ),
                                    Spacer(),
                                    Builder(
                                      builder: (ctx) => Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: IconButton(
                                            icon: Icon(
                                              Icons.menu,
                                            ),
                                            onPressed: () => Scaffold.of(ctx)
                                                .openEndDrawer()),
                                      ),
                                    ),
                                  ]),
                        body: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Title(
                            title: notice.title,
                            color: Colors.black,
                            child: ScreenTypeLayout(
                                mobile: NoticeInfoPageMobile(notice),
                                desktop: StickyHeader(
                                    header: CustomAppBar(),
                                    content: NoticeInfoPageDesktop(notice))),
                          ),
                        ),
                      ),
                    );
                  } else if (snp.hasError) {
                    return ErrorLoad(color: Theme.of(context).primaryColor);
                  } else {
                    return CustomLoading();
                  }
                });
        }
      },
    );
  }

  loadData() async {
    final noticeStore = Provider.of<NoticeStore>(context);
    return await noticeStore.getNoticeById(widget.id);
  }
}

/// Tela responsável por exibir a página de atualizar Notícia (Admin).
///
/// {@category Screen}
// ignore: library_names
library AdminUpdateNoticeScreen;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Components/widget/customLoading_component.dart';
import 'package:site_historia/Components/page/adminUpdateNotice_page.dart';
import 'package:site_historia/Desktop/appBar/verticalAppBar_desktop.dart';
import 'package:site_historia/Mobile/drawer/adminNavigation_drawer_component.dart';
import 'package:site_historia/Model/notice_model.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Screens/loading_screen.dart';
import 'package:site_historia/Store/notice_store.dart';
import 'package:site_historia/Support/routesName_support.dart';

/// O Widget redireciona para duas telas diferentes, o desktop conta com o `VerticalAppBar` e a mobile
/// possui `AdminNavigatorDrawerMobile`. O método `getNotices()` é chamado  para
/// carregar as informações de professor do banco de dados.
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
          drawer: sizingInformation.isDesktop ? null : AdminNavigatorDrawerMobile(),
          appBar: sizingInformation.isDesktop
              ? null
              : AppBar(
                  centerTitle: true,
                  title: SelectableText("Editar Notícia"),
                ),
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
                              mobile: AdminUpdateNoticePage(notice),
                              desktop: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                  VerticalAppBar(),
                                  Expanded(
                                      child: AdminUpdateNoticePage(notice)),
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

/// Widget responsável por exibir a página de notícias (versão mobile).
///
/// {@category Mobile}
/// {@subCategory Page}
// ignore: library_names
library NoticePageMobile;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/widget/customLoading_component.dart';
import 'package:site_historia/Components/widget/customText_component.dart';
import 'package:site_historia/Mobile/footer/footer_mobile.dart';
import 'package:site_historia/Mobile/widget/listNotices_mobile.dart';
import 'package:site_historia/Mobile/widget/menuBarNotices_mobile.dart';
import 'package:site_historia/Model/notice_model.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Store/notice_store.dart';

/// Widget carrega todas as notícias através do método `getNotices()`.
/// Usa o widget `MenuBarNoticesMobile()` que monta o menu de seleção de filtros e o `ListNoticesMobile()`
/// que exibe a lista de notícias.
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
        child: CustomText("Notícias",
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
            return Column(children: [ListNoticesMobile(listNotice),FooterMobile(),]);
        }
      }),

    ]);
  }
}

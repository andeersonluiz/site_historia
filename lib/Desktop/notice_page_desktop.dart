/// Widget responsável por exibir a página de notícias (versão desktop).
///
/// {@category Desktop}
/// {@subCategory Page}
// ignore: library_names
library NoticePageDesktop;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/widget/customLoading_component.dart';
import 'package:site_historia/Components/widget/customText_component.dart';
import 'package:site_historia/Desktop/footer/footer_desktop.dart';
import 'package:site_historia/Desktop/widget/listNotices_desktop.dart';
import 'package:site_historia/Desktop/widget/menuBarNotices_desktop.dart';
import 'package:site_historia/Model/notice_model.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Store/notice_store.dart';

/// Widget carrega todas as notícias através do método `getNotices()`.
/// Usa o widget `MenuBarNoticesDesktop()` que monta o menu de seleção de filtros e o `ListNoticesDesktop()`
/// que exibe a lista de notícias.
class NoticePageDesktop extends StatefulWidget {
  @override
  _NoticePageDesktopState createState() => _NoticePageDesktopState();
}

class _NoticePageDesktopState extends State<NoticePageDesktop> {
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
      MenuBarNoticesDesktop(),
      Observer(builder: (_) {
        switch (noticeStore!.listNoticesFiltered!.status) {
          case FutureStatus.pending:
            return CustomLoading();
          case FutureStatus.rejected:
            return ErrorLoad(color: Theme.of(context).primaryColor);
          case FutureStatus.fulfilled:
            List<Notice> listNotice =
                noticeStore!.listNoticesFiltered!.value as List<Notice>;
            if(listNotice.isEmpty){
              return Container(
                height: 500,
                child:Column(
                  children: [Expanded(
                    child: Center(
                      child: CustomText(
                        "Não foram encontrados resultados para sua pesquisa :(",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                  ),FooterDesktop(),

                  ]
                ),
              );
            }
            return Container(
                constraints: BoxConstraints(
                  minHeight: 500,
                ),
                child: Column(children: [ListNoticesDesktop(listNotice),listNotice.length==1?Container(height: 100,):Container(),FooterDesktop(),]));
        }
      }),

    ]);
  }
}

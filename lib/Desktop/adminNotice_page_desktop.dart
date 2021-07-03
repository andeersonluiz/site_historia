/// Widget responsável por exibir a lista de notícias (Admin - versão desktop).
///
/// {@category Desktop}
/// {@subCategory Page}
// ignore: library_names
library AdminNoticePageDesktop;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/widget/customText_component.dart';
import 'package:site_historia/Components/widget/customLoading_component.dart';
import 'package:site_historia/Components/widget/customToast_component.dart';
import 'package:site_historia/Desktop/widget/adminNoticeCard_desktop.dart';
import 'package:site_historia/Model/notice_model.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Store/notice_store.dart';
import 'package:site_historia/Support/routesName_support.dart';
import 'package:velocity_x/velocity_x.dart';

/// Widget carrega todas as notícias através do método `getNotices()`. É composto pelo
/// widget `AdminNoticeCardDesktop(Notice noticia)` que monta a exibição de cada notícia.
class AdminNoticePageDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final noticeStore = Provider.of<NoticeStore>(context);

    return Expanded(
      child: Observer(builder: (ctx) {
        noticeStore.listNotices ?? noticeStore.getNotices();
        switch (noticeStore.listNotices!.status) {
          case FutureStatus.pending:
            return CustomLoading();
          case FutureStatus.rejected:
            return ErrorLoad(
              color: Theme.of(context).primaryColor,
            );
          case FutureStatus.fulfilled:
            List<Notice> listNotices =
                noticeStore.listNotices!.value as List<Notice>;
            return ListView(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        margin: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                              width: 1.0,
                              color: Theme.of(context).primaryColor),
                        ),
                        child: ListTile(
                          leading: Icon(Icons.add_circle_rounded),
                          title: CustomText("Adicionar Noticia",isSelectable: false,
                              style: Theme.of(context).textTheme.bodyText1),
                          onTap: () => VxNavigator.of(context)
                              .push(Uri.parse(RouteNames.ADD_NOTICE)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Observer(
                        builder: (_) => Container(
                          margin: EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(
                                width: 1.0,
                                color: Theme.of(context).primaryColor),
                          ),
                          child: noticeStore.isEditing
                              ? ListTile(
                                  leading: Icon(Icons.check_circle),
                                  title: CustomText("Salvar Alterações",
                                      isSelectable: false,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                  onTap: () {
                                    noticeStore.changeEditing();
                                    noticeStore.updateNotices(
                                        noticeStore.listNotices!.value);
                                    CustomToast.showToast(
                                        "Alterações salvas", Colors.green);
                                  })
                              : ListTile(
                                  leading: Icon(Icons.edit),
                                  title: CustomText("Editar Menu Principal",isSelectable: false,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                  onTap: () => noticeStore.changeEditing()),
                        ),
                      ),
                    ),
                  ],
                ),
                for (int i = 0; i < listNotices.length; i++) AdminNoticeCardDesktop(i),
              ],
            );
        }
      }),
    );
  }
}

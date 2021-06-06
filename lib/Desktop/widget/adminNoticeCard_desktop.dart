/// Widget responsável por exibir um card com informações do notícia (Admin - desktop).
///
/// {@category Desktop}
/// {@subCategory Widget}
// ignore: library_names
library AdminNoticeCardDesktop;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/widget/customButton_component.dart';
import 'package:site_historia/Components/widget/customImage_component.dart';
import 'package:site_historia/Components/widget/customText_component.dart';
import 'package:site_historia/Model/notice_model.dart';
import 'package:site_historia/Store/notice_store.dart';
import 'package:site_historia/Support/routesName_support.dart';
import 'package:velocity_x/velocity_x.dart';

/// É feita a montagem do card, onde recebe o index da Notícia que contém informações como:
/// título da notícia, data de postagem, autor, imagem, opções de excluir e editar notícia.
/// Quando selecionada a opção de excluir é exibido um pop up confirmando a exclusão e no editar
/// é redirecionado para rota `RouteNames.UPDATE_NOTICE`.
class AdminNoticeCardDesktop extends StatelessWidget {
  final int index;
  final double sizeCard = 200;
  AdminNoticeCardDesktop(this.index);
  @override
  Widget build(BuildContext context) {
    NoticeStore noticeStore = Provider.of<NoticeStore>(context);

    return Container(
        padding: EdgeInsets.all(8.0),
        child: Card(
            elevation: 10,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            semanticContainer: true,
            child: Column(
              children: [
                Container(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Observer(
                        builder: (_) => noticeStore.isEditing
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomText(
                                  "Menu Principal?",
                                  style: Theme.of(context).textTheme.button,
                                ),
                              )
                            : Container(),
                      ),
                      Observer(
                        builder: (_) => noticeStore.isEditing
                            ? FlutterSwitch(
                                width: 70.0,
                                height: 30.0,
                                valueFontSize: 15.0,
                                toggleSize: 30.0,
                                value: noticeStore
                                    .listNotices!.value[index].isTopHeader,
                                borderRadius: 30.0,
                                padding: 8.0,
                                onToggle: (value) {
                                  noticeStore.verifyTopHeaders(
                                      noticeStore.listNotices!.value[index],
                                      value);
                                },
                              )
                            : Container(),
                      ),
                      Spacer(),
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () => VxNavigator.of(context).push(Uri(
                            path: RouteNames.UPDATE_NOTICE,
                            queryParameters: {
                              "id": noticeStore.listNotices!.value[index].id
                                  .toString()
                            })),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Theme.of(context).primaryColor,
                        ),
                        onPressed: () => _showMaterialDialog(context,
                            noticeStore.listNotices!.value[index], noticeStore),
                      ),
                    ],
                  ),
                ),
                Row(children: [
                  Expanded(
                      flex: 3,
                      child: CustomImage(
                          image: noticeStore.listNotices!.value[index].thumb,
                          height: sizeCard)),
                  Expanded(
                    flex: 7,
                    child: Container(
                      height: sizeCard,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Spacer(),
                            Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    noticeStore.listNotices!.value[index].title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                            color: Theme.of(context)
                                                .primaryColor)),
                              ),
                            ),
                            Spacer(),
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      "Autor: " +
                                          noticeStore
                                              .listNotices!.value[index].author,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                ),
                                Spacer(),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      "Data do Post: " +
                                          noticeStore.listNotices!.value[index]
                                              .datePost,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                              color: Theme.of(context)
                                                  .primaryColor)),
                                )
                              ],
                            ),
                          ]),
                    ),
                  ),
                ]),
              ],
            )));
  }

  _showMaterialDialog(
      BuildContext context, Notice notice, NoticeStore noticeStore) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new CustomText(
                "Confirmar Exclusão",
                style: Theme.of(context).textTheme.headline5,
              ),
              content: new CustomText(
                "Tem certeza que deseja excluir o projeto ${notice.title}?",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              actions: <Widget>[
                CustomButton(
                    text: "Sim",
                    onPressed: () async {
                      await noticeStore.deleteNotice(notice.id);
                      noticeStore.getNotices();
                      Navigator.of(context).pop();
                    }),
                CustomButton(
                  text: "Não",
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }
}

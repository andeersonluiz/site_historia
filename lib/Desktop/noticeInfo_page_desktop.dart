/// Widget responsável por exibir informações de notícias (versão desktop).
///
/// {@category Desktop}
/// {@subCategory Page}
// ignore: library_names
library NoticeInfoPageDesktop;
import 'package:flutter/material.dart';
import 'package:site_historia/Components/widget/audioViewer_component.dart';
import 'package:site_historia/Components/widget/author_component.dart';
import 'package:site_historia/Components/widget/customText_component.dart';
import 'package:site_historia/Components/widget/htmlViewer_component.dart';
import 'package:site_historia/Desktop/footer/footer_desktop.dart';
import 'package:site_historia/Model/notice_model.dart';
import 'package:site_historia/Support/globals_variables.dart';

/// Widget que recebe um objeto `Notice`. Onde são organizadas as informações da notícia.
/// Utiliza o widget `HtmlViewer(String conteudo)` para generalizar o visualizador de html,
/// `AuthorInfo(String author, String datePost)` para generalizar a exibição
/// de informações sobre o autor e o `AudioViewer(String url)` para exibir o áudio.
class NoticeInfoPageDesktop extends StatelessWidget {
  final Notice notice;
  NoticeInfoPageDesktop(this.notice);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height-GlobalsVariables.sizeFooterDesktop,
        maxHeight: double.infinity,
      ),
      child: IntrinsicHeight(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomText(notice.title,
                  style: Theme.of(context).textTheme.headline3),
            ),
            CustomText(
              notice.subtitle,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Divider(
              thickness: 1.0,
            ),
            Container(
                constraints: BoxConstraints(
                  minHeight: 400,
                ),
                child: HtmlViewer(
                  notice.content,
                  margin: EdgeInsets.only(
                      left: 100.0, right: 100.0, top: 16.0, bottom: 16.0),

                )),
            notice.type == "Podcast"
                ? Divider(
                    thickness: 1.0,
                  )
                : Container(),
            notice.type == "Podcast" ? AudioViewer(notice.audio[1]) : Container(),
            Divider(
              thickness: 1.0,
            ),
            AuthorInfo(author: notice.author, datePost: notice.datePost),
            Expanded(child: FooterDesktop()),
          ],
        ),
      ),
    );
  }
}

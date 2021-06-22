/// Widget responsável por exibir as informações de quadros (versão mobile).
///
/// {@category Mobile}
/// {@subCategory Page}
// ignore: library_names
library FramePageMobile;
import 'package:flutter/material.dart';
import 'package:site_historia/Components/widget/audioViewer_component.dart';
import 'package:site_historia/Components/widget/author_component.dart';
import 'package:site_historia/Components/widget/customImage_component.dart';
import 'package:site_historia/Components/widget/customText_component.dart';
import 'package:site_historia/Components/widget/htmlViewer_component.dart';
import 'package:site_historia/Components/widget/videoViewer_component.dart';
import 'package:site_historia/Mobile/footer/footer_mobile.dart';
import 'package:site_historia/Model/frame_model.dart';

/// Widget que recebe um objeto `Frame`. Onde são organizadas as informações do quadro.
/// Utiliza o widget `HtmlViewer(String conteudo)` para generalizar o visualizador de html,
/// `AuthorInfo(String author, String datePost)` para generalizar a exibição
/// de informações sobre o autor, `AudioViewer(String url)` para exibir o áudio e o `VideoViewer(String url`)
/// para exibir o vídeo.
class FramePageMobile extends StatelessWidget {
  final Frame frame;

  FramePageMobile(this.frame);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomText(frame.title,
              style: Theme.of(context).textTheme.headline4),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: CustomText(
            frame.subtitle,
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        Divider(
          thickness: 1.0,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 8.0,bottom: 0.0,left: 16.0,right: 16.0),
          child: CustomImage(
            width: 500,
            height: 300,
            image: frame.imageHeader,
          ),
        ),
        CustomText(
          frame.subtitleImage,
          padding: const EdgeInsets.only(top: 0.0,bottom: 8.0,left: 16.0,right: 16.0),
          style: Theme.of(context).textTheme.caption,
        ),
        HtmlViewer(
          frame.content,
          margin:EdgeInsets.all(16.0)
        ),
        Divider(
          thickness: 1.0,
        ),
        frame.urlAudio[1] != "" ? AudioViewer(frame.urlAudio[1],margin: 16.0,) : Container(),
        frame.urlAudio[1] != ""
            ? Divider(
                thickness: 1.0,
              )
            : Container(),
        frame.urlVideo[1] != "" ? VideoViewer(frame.urlVideo[1]) : Container(),
        frame.urlVideo[1] != ""
            ? Divider(
                thickness: 1.0,
              )
            : Container(),
        AuthorInfo(author: frame.author, datePost: frame.datePost),
        FooterMobile(),
      ],
    );
  }
}

/// Widget responsável por exibir a seção "Sobre nós" no footer.
///
/// {@category Component}
/// {@subCategory Widget}
// ignore: library_names
library About;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class About extends StatelessWidget {
  final CrossAxisAlignment iconContactAlign;
  final TextAlign textAlign;
  final MainAxisAlignment iconSocialsAlign;
  final double sizeContainerText;
  About(
      {required this.iconContactAlign,
      required this.textAlign,
      required this.iconSocialsAlign,
      this.sizeContainerText = double.infinity});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: iconContactAlign,
      children: [
        SelectableText('Sobre nós',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        Container(
          padding: EdgeInsets.only(right: 16.0),
          width: sizeContainerText,
          child: SelectableText(
            "Site da Coordenação de História do CEFET/Maracanã. Concebido, organizado e mantido pela professora Mariana Renou e os monitores: Lucas Muniz, Maria Eduarda Schwartz e Mariana Araújo. Desenvolvido e programado por Anderson Luiz Bernardes da Rocha.",            maxLines: 3,
            style: Theme.of(context).textTheme.caption,
            textAlign: textAlign,
          ),
        ),
        Row(
          crossAxisAlignment: iconContactAlign,
          mainAxisAlignment: iconSocialsAlign,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: InkWell(
                  onTap: () {
                        _launchURL("https://www.instagram.com/historia.cefetrj/");
                  },
                  child: Icon(
                    FontAwesomeIcons.instagramSquare,
                    size: 30,
                  )),
            ),
            InkWell(
                onTap: () {
                  _launchURL("https://www.youtube.com/channel/UC4qs9NuHpSUB9U1-R29HNWg");
                },
                child: Icon(
                  FontAwesomeIcons.youtubeSquare,
                  size: 30,
                )),
          ],
        ),
      ],
    );
  }
  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

}

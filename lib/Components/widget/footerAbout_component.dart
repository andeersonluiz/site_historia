/// Widget responsável por exibir a seção "Sobre nós" no footer.
///
/// {@category Component}
/// {@subCategory Widget}
// ignore: library_names
library About;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
        Text('Sobre nós',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        Container(
          padding: EdgeInsets.only(right: 16.0),
          width: sizeContainerText,
          child: Text(
            'dapskdoapkdopaskdopa kdopas kodaspk opasdkoapspk dopask dopaskdopaskdopak opapsk dpoasdkopa sk dsadk aospkd askdosapk daopskd opsak dopas kdopsak dopsak opsadk osapko',
            maxLines: 3,
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
              child: GestureDetector(
                  onTap: () {},
                  child: Icon(
                    FontAwesomeIcons.facebookSquare,
                    size: 30,
                  )),
            ),
            GestureDetector(
                onTap: () {},
                child: Icon(
                  FontAwesomeIcons.instagramSquare,
                  size: 30,
                )),
          ],
        ),
      ],
    );
  }
}

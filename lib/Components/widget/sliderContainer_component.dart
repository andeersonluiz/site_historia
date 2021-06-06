/// Widget responsável pela visualização do conteúdo em `SliderImage`.
///
/// {@category Component}
/// {@subCategory Widget}
// ignore: library_names
library SliderContainer;

import 'package:flutter/material.dart';

import '../../Model/notice_model.dart';
import 'customImage_component.dart';

/// Exibe as informações de notícias através do objeto `Notice`.
class SliderContainer extends StatelessWidget {
  final Notice notice;
  final double sizeContainer;
  final maxLinesSubtitle;
  SliderContainer({
    required this.notice,
    required this.sizeContainer,
    required this.maxLinesSubtitle,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            width: double.infinity,
            height: double.infinity,
            child: CustomImage(
              image: notice.thumb,
              padding: EdgeInsets.zero,
            )),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            width: double.infinity,
            height: sizeContainer,
            color: Theme.of(context).selectedRowColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        notice.title,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          notice.subtitle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: maxLinesSubtitle,
                          textAlign: TextAlign.left,
                          style: Theme.of(context).textTheme.subtitle1),
                    ),
                  ]),
            ),
          ),
        ),
      ],
    );
  }
}

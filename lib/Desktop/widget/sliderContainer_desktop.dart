import 'package:flutter/material.dart';
import 'package:site_historia/model/notice_model.dart';

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
          child: Image.network(
            notice.imageHeader,
            fit: BoxFit.fill,
          ),
        ),
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
                    Text(notice.subtitle,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.subtitle1),
                  ]),
            ),
          ),
        ),
      ],
    );
  }
}

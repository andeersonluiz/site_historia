import 'package:flutter/material.dart';
import 'package:site_historia/Components/audioViewer_component.dart';
import 'package:site_historia/Components/author_component.dart';
import 'package:site_historia/Components/customImage_component.dart';
import 'package:site_historia/Components/customText_component.dart';
import 'package:site_historia/Components/htmlViewer_component.dart';
import 'package:site_historia/Components/videoViewer_component.dart';
import 'package:site_historia/Desktop/footer/footer_desktop.dart';
import 'package:site_historia/Mobile/footer/footer_mobile.dart';
import 'package:site_historia/Model/frame_model.dart';

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
        CustomText(
          frame.subtitle,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        Divider(
          thickness: 1.0,
        ),
        CustomImage(
          width: 500,
          height: 300,
          image: frame.imageHeader,
        ),
        CustomText(
          frame.subtitleImage,
          style: Theme.of(context).textTheme.caption,
        ),
        HtmlViewer(
          frame.content,
          margin: EdgeInsets.only(
              left: 100.0, right: 100.0, top: 16.0, bottom: 16.0),
        ),
        Divider(
          thickness: 1.0,
        ),
        frame.urlAudio[1] != "" ? AudioViewer(frame.urlAudio[1]) : Container(),
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

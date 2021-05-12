import 'package:flutter/material.dart';
import 'package:site_historia/Components/audioViewer_component.dart';
import 'package:site_historia/Components/author_component.dart';
import 'package:site_historia/Components/customText_component.dart';
import 'package:site_historia/Components/htmlViewer_component.dart';
import 'package:site_historia/Desktop/footer/footer_desktop.dart';
import 'package:site_historia/Model/notice_model.dart';

class NoticeInfoPageDesktop extends StatelessWidget {
  final Notice notice;
  NoticeInfoPageDesktop(this.notice);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
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
        FooterDesktop(),
      ],
    );
  }
}

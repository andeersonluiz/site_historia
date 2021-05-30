import 'package:flutter/material.dart';
import 'package:site_historia/Components/widget/audioViewer_component.dart';
import 'package:site_historia/Components/widget/author_component.dart';
import 'package:site_historia/Components/widget/customText_component.dart';
import 'package:site_historia/Components/widget/htmlViewer_component.dart';
import 'package:site_historia/Desktop/footer/footer_desktop.dart';
import 'package:site_historia/Model/notice_model.dart';

class NoticeInfoPageDesktop extends StatelessWidget {
  final Notice notice;
  NoticeInfoPageDesktop(this.notice);

  @override
  Widget build(BuildContext context) {
    return Column(
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

import 'package:flutter/material.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

import '../Theme/ThemeConfig.dart';
import 'appBar/custtomAppBar_desktop.dart';
import 'footer/footer_desktop.dart';
import 'widget/latestPodcast_desktop.dart';
import 'widget/latestPosts_desktop.dart';
import 'widget/sliderImage_desktop.dart';

class HomePageDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StickyHeader(
        header: CustomAppBar(),
        content: Column(children: [
          SliderImageDesktop(),
          Divider(height: 1),
          Row(children: [
            Expanded(flex: 5, child: LatestPosts()),
            Expanded(
                flex: 5,
                child: Container(
                    height: 500,
                    color: ThemeConfig.brownPodcast,
                    child: LatestPodcast())),
          ]),
          Divider(height: 1),
          FooterDesktop(),
        ]));
  }
}

import 'package:flutter/material.dart';
import 'package:site_historia/Desktop/appBar/custtomAppBar_component.dart';
import 'package:site_historia/Desktop/footer/footer_desktop.dart';
import 'package:site_historia/Desktop/widget/latestPodcast_desktop.dart';
import 'package:site_historia/Desktop/widget/latestPosts_desktop.dart';
import 'package:site_historia/Desktop/widget/sliderImage_desktop.dart';
import 'package:site_historia/Theme/ThemeConfig.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

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

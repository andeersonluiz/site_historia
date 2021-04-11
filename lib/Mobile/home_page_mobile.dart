import 'package:flutter/material.dart';

import '../Theme/ThemeConfig.dart';
import 'footer/footer_mobile.dart';
import 'widget/latestPodcast_mobile.dart';
import 'widget/latestPosts_mobile.dart';
import 'widget/sliderImage_mobile.dart';

class HomePageMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        SliderImageMobile(),
        Divider(height: 1),
        width > 600
            ? Row(children: [
                Expanded(flex: 5, child: LatestPostsMobile(0.45)),
                Expanded(
                    flex: 5,
                    child: Container(
                        height: 500,
                        color: ThemeConfig.brownPodcast,
                        child: LatestPodcastMobile(0.45))),
              ])
            : Column(children: [
                Container(
                    height: 500,
                    width: MediaQuery.of(context).size.width,
                    child: LatestPostsMobile(1)),
                Container(
                    height: 500,
                    width: MediaQuery.of(context).size.width,
                    color: ThemeConfig.brownPodcast,
                    child: LatestPodcastMobile(1)),
              ]),
        Divider(height: 1),
        FooterMobile(),
      ],
    );
  }
}

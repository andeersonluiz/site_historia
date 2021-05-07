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
        Divider(
          thickness: 1.0,
          height: 0,
        ),
        width > 600
            ? Row(children: [
                Expanded(flex: 5, child: LatestPostsMobile(0.45)),
                Expanded(
                    flex: 5,
                    child: Container(
                        color: ThemeConfig.brownPodcast,
                        child: LatestPodcastMobile(widthPercentualSize: 0.45))),
              ])
            : Column(children: [
                Container(
                    width: MediaQuery.of(context).size.width,
                    child: LatestPostsMobile(1)),
                Container(
                    width: MediaQuery.of(context).size.width,
                    color: ThemeConfig.brownPodcast,
                    child: LatestPodcastMobile(widthPercentualSize: 1)),
              ]),
        Divider(
          thickness: 1.0,
          height: 0,
        ),
        FooterMobile(),
      ],
    );
  }
}

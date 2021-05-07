import 'package:flutter/material.dart';

import '../Theme/ThemeConfig.dart';
import 'footer/footer_desktop.dart';
import 'widget/latestPodcast_desktop.dart';
import 'widget/latestPosts_desktop.dart';
import 'widget/sliderImage_desktop.dart';

class HomePageDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      SliderImageDesktop(),
      Divider(height: 1),
      Row(children: [
        Expanded(flex: 5, child: Container(height: 525, child: LatestPosts())),
        Expanded(
            flex: 5,
            child: Container(
                height: 525,
                color: ThemeConfig.brownPodcast,
                child: LatestPodcast())),
      ]),
      Divider(height: 1),
      FooterDesktop(),
    ]);
  }
}

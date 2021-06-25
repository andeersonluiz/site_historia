/// Widget responsável por exibir a página inicial (versão mobile).
///
/// {@category Mobile}
/// {@subCategory Page}
// ignore: library_names
library HomePageMobile;
import 'package:flutter/material.dart';

import '../Theme/themeConfig.dart';
import 'footer/footer_mobile.dart';
import 'widget/latestPodcast_mobile.dart';
import 'widget/latestPosts_mobile.dart';
import 'widget/sliderImage_mobile.dart';

/// A tela inicial utiliza os widgets `SliderImageMobile()` que exibe o Carousel com as notícias e
/// usa os widgets `LatestPostsMobile()` e `LatestPodcastMobile()` para exibir, respectivamente, as postagens e podcasts
/// mais recente.
class HomePageMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
        maxHeight: double.infinity,
      ),
      child: IntrinsicHeight(
        child: Column(
          children: [
            Expanded(child: SliderImageMobile()),
            Divider(
              thickness: 1.0,
              height: 0,
            ),
            width > 600
                ? IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                      Expanded(flex: 5, child: Container(constraints: BoxConstraints(
                        minHeight: 525,
                      ),child: LatestPostsMobile(0.45))),
                      Expanded(
                          flex: 5,
                          child: Container(
                              color: ThemeConfig.brownPodcast,
                              child: Container(constraints: BoxConstraints(
                                minHeight: 525,
                              ),child: LatestPodcastMobile(widthPercentageSize: 0.45)))),
                    ]),
                )
                : Column(children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: LatestPostsMobile(1)),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        color: ThemeConfig.brownPodcast,
                        child: LatestPodcastMobile(widthPercentageSize: 1)),
                  ]),
            Divider(
              thickness: 1.0,
              height: 0,
            ),
            FooterMobile(),
          ],
        ),
      ),
    );
  }
}

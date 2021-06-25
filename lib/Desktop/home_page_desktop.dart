/// Widget responsável por exibir a página inicial (versão desktop).
///
/// {@category Desktop}
/// {@subCategory Page}
// ignore: library_names
library HomePageDesktop;
import 'package:flutter/material.dart';
import 'package:site_historia/Support/globals_variables.dart';

import '../Theme/themeConfig.dart';
import 'footer/footer_desktop.dart';
import 'widget/latestPodcast_desktop.dart';
import 'widget/latestPosts_desktop.dart';
import 'widget/sliderImage_desktop.dart';

/// A tela inicial utiliza os widgets `SliderImageDesktop()` que exibe o Carousel com as notícias e
/// usa os widgets `LatestPostsDesktop()` e `LatestPodcastDesktop()` para exibir, respectivamente, as postagens e podcasts
/// mais recente.
class HomePageDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
        maxHeight: double.infinity,
      ),
      child: IntrinsicHeight(
        child: Column(children: [
          SliderImageDesktop(),
          Divider(height: 1),
          IntrinsicHeight(
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
              Expanded(flex: 5, child: Container(constraints: BoxConstraints(
        minHeight: 525,
        ), child: LatestPostsDesktop())),
              Expanded(
                  flex: 5,
                  child: Container(
                      constraints: BoxConstraints(
        minHeight: 525,
        ),
                      color: ThemeConfig.brownPodcast,
                      child: LatestPodcastDesktop())),
            ]),
          ),
          Divider(height: 1),
          Expanded(child: FooterDesktop()),
        ]),
      ),
    );
  }
}

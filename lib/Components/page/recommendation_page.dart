/// Widget responsável por exibir a página de recomendações.
///
/// {@category Component}
/// {@subCategory Page}
// ignore: library_names
library RecommendationPage;

import 'package:flutter/material.dart';
import 'package:site_historia/Components/widget/customText_component.dart';
import 'package:site_historia/Desktop/footer/footer_desktop.dart';
import 'package:site_historia/Components/widget/recommendationItem_component.dart';
import 'package:site_historia/Model/recommendationItem_model.dart';
import 'package:site_historia/Model/recommendation_model.dart';

/// A tela de recomendações utiliza o objeto `Recommendation` e o widget `RecommendationItemWidget()` para exibir
/// as variáveis do objeto de acordo com o tipo que são: youtube, blog, podcast e outros.
class RecommendationPage extends StatelessWidget {
  final Recommendation recommendations;
  RecommendationPage(this.recommendations);
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomText("Recomendações",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4!),
              ),
              Divider(
                thickness: 1.0,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  "Youtube",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              for (RecommendationItem rec in recommendations.youtubeList)
                RecommendationItemWidget(rec),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  "Blog",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              for (RecommendationItem rec in recommendations.blogList)
                RecommendationItemWidget(rec),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  "Podcast",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              for (RecommendationItem rec in recommendations.podcastList)
                RecommendationItemWidget(rec),
              Align(
                alignment: Alignment.centerLeft,
                child: CustomText(
                  "Outros",
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.headline5,
                ),
              ),
              for (RecommendationItem rec in recommendations.othersList)
                RecommendationItemWidget(rec),
            ],
          )),
      FooterDesktop(),
    ]);
  }
}

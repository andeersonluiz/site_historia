/// Widget responsável por exibir as recomendações na página `recommendation_page´.
///
/// {@category Component}
/// {@subCategory Widget}
// ignore: library_names
library RecommendationItemWidget;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:site_historia/Model/recommendationItem_model.dart';
import 'package:url_launcher/url_launcher.dart';

/// Recebe um objeto `RecommendationItem`, onde exibe o nome do item e sua url.
class RecommendationItemWidget extends StatelessWidget {
  final RecommendationItem recommendationItem;
  RecommendationItemWidget(this.recommendationItem);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RichText(
          text: TextSpan(children: [
            WidgetSpan(
              alignment: PlaceholderAlignment.middle,
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 8.0),
                child: Icon(Icons.circle,
                    size: 13, color: Theme.of(context).primaryColor),
              ),
            ),
            TextSpan(
              text: recommendationItem.name + " - ",
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
            TextSpan(
                text: "link",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Colors.blueAccent,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blueAccent),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    if (!recommendationItem.url.contains("http://") &&
                        !recommendationItem.url.contains("https://")) {
                      recommendationItem.url =
                          "https://" + recommendationItem.url;
                    }
                    _launchURL(recommendationItem.url);
                  })
          ]),
        ),
      ),
    );
  }

  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}

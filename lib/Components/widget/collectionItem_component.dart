/// Widget responsável por exibir os acervos na página `collection_page´.
///
/// {@category Component}
/// {@subCategory Widget}
// ignore: library_names
library CollectionItemWidget;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:site_historia/Model/collection_item.dart';
import 'package:url_launcher/url_launcher.dart';

/// Recebe um objeto `CollectionItemWidget`, onde exibe o nome do item e sua url.
class CollectionItemWidget extends StatelessWidget {
  final CollectionItem collectionItem;
  final bool isExam;
  CollectionItemWidget(this.collectionItem, {this.isExam = false});
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
              text: collectionItem.name + " - ",
              style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
            TextSpan(
                text: isExam ? "Acessar" : "Baixar",
                style: Theme.of(context).textTheme.subtitle1!.copyWith(
                    color: Colors.blueAccent,
                    decoration: TextDecoration.underline,
                    decorationColor: Colors.blueAccent),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    if (!collectionItem.url.contains("http://") &&
                        !collectionItem.url.contains("https://")) {
                      collectionItem.url = "https://" + collectionItem.url;
                    }
                    _launchURL(collectionItem.url);
                  })
          ]),
        ),
      ),
    );
  }

  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}

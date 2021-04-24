import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/dom.dart' as dom;

class HtmlViewer extends StatelessWidget {
  final String content;
  HtmlViewer(this.content);

  @override
  Widget build(BuildContext context) {
    return Html(
      data: content,
      style: {
        "p": Style(color: Theme.of(context).primaryColor),
        "pre": Style(
            color: Theme.of(context).primaryColor, whiteSpace: WhiteSpace.PRE),
        "h1": Style(color: Theme.of(context).primaryColor),
        "h2": Style(color: Theme.of(context).primaryColor),
        "h3": Style(color: Theme.of(context).primaryColor),
        "h4": Style(color: Theme.of(context).primaryColor),
        "h5": Style(color: Theme.of(context).primaryColor),
        "h6": Style(color: Theme.of(context).primaryColor),
        "b": Style(
          fontWeight: FontWeight.bold,
        ),
        "u": Style(
            textDecoration: TextDecoration.underline,
            textDecorationColor: Theme.of(context).primaryColor),
        "li": Style(color: Theme.of(context).primaryColor),
        "ul": Style(
            margin: EdgeInsets.symmetric(vertical: 20),
            color: Theme.of(context).primaryColor),
        "table": Style(
            border: Border.all(color: Theme.of(context).primaryColor),
            color: Theme.of(context).primaryColor),
        "tbody": Style(
            border: Border.all(color: Theme.of(context).primaryColor),
            color: Theme.of(context).primaryColor),
        "tr": Style(
            border: Border.all(color: Theme.of(context).primaryColor),
            color: Theme.of(context).primaryColor),
        "td": Style(
            padding: EdgeInsets.all(8.0),
            color: Theme.of(context).primaryColor),
      },
      customRender: {
        "li": (ctx, child, attributtes, element) {
          return customListItem(context, element);
        },
        "a": (ctx, child, attributtes, element) {
          return customHyperLink(
              context, attributtes['href'].toString(), element);
        },
        "img": (ctx, child, attributtes, element) {
          return customImage(context, attributtes);
        }
      },
    );
  }

  Wrap customListItem(
    BuildContext context,
    dom.Element? node,
  ) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 4,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: CircleAvatar(
            radius: 3,
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),
        Text(
          node!.text,
          style: TextStyle(color: Theme.of(context).primaryColor),
        )
      ],
    );
  }

  InkWell customHyperLink(
    BuildContext context,
    String href,
    dom.Element? node,
  ) {
    return InkWell(
      onTap: () {
        _launchURL(href);
      },
      child: Text(
        node!.text,
        style: TextStyle(
            color: Colors.blueAccent,
            decoration: TextDecoration.underline,
            decorationColor: Colors.blueAccent),
      ),
    );
  }

  Image customImage(
    BuildContext context,
    Map<String, String> attributes,
  ) {
    if (attributes["class"] == "emoji-img-inline") {
      return Image.network(attributes["src"].toString(), scale: 4);
    } else {
      return Image.network(attributes["src"].toString(), scale: 1);
    }
  }

  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}

import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:html/dom.dart' as dom;

class HtmlViewer extends StatelessWidget {
  final String content;
  final EdgeInsetsGeometry? margin;
  HtmlViewer(this.content, {this.margin = const EdgeInsets.all(16.0)});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: Html(
        data: content,
        style: {
          "p": Style(
            color: Theme.of(context).primaryColor,
            fontSize: FontSize(16.0),
          ),
          "pre": Style(
              color: Theme.of(context).primaryColor,
              whiteSpace: WhiteSpace.PRE),
          "h1": Style(
              color: Theme.of(context).primaryColor, fontSize: FontSize(32.0)),
          "h2": Style(
              color: Theme.of(context).primaryColor, fontSize: FontSize(24.0)),
          "h3": Style(
              color: Theme.of(context).primaryColor, fontSize: FontSize(18.0)),
          "h4": Style(
              color: Theme.of(context).primaryColor, fontSize: FontSize(16.0)),
          "h5": Style(
              color: Theme.of(context).primaryColor, fontSize: FontSize(13.0)),
          "h6": Style(
              color: Theme.of(context).primaryColor, fontSize: FontSize(10.0)),
          "b": Style(fontWeight: FontWeight.bold, fontSize: FontSize(16.0)),
          "u": Style(
              textDecoration: TextDecoration.underline,
              textDecorationColor: Theme.of(context).primaryColor,
              fontSize: FontSize(16.0)),
          "li": Style(
              color: Theme.of(context).primaryColor, fontSize: FontSize(16.0)),
          "ul": Style(
              margin: EdgeInsets.symmetric(vertical: 20),
              color: Theme.of(context).primaryColor,
              fontSize: FontSize(16.0)),
          "table": Style(
              border: Border.all(color: Theme.of(context).primaryColor),
              color: Theme.of(context).primaryColor,
              fontSize: FontSize(16.0)),
          "tbody": Style(
              border: Border.all(color: Theme.of(context).primaryColor),
              color: Theme.of(context).primaryColor,
              fontSize: FontSize(16.0)),
          "tr": Style(
              border: Border.all(color: Theme.of(context).primaryColor),
              color: Theme.of(context).primaryColor,
              fontSize: FontSize(16.0)),
          "td": Style(
              padding: EdgeInsets.all(8.0),
              color: Theme.of(context).primaryColor,
              fontSize: FontSize(16.0)),
        },
        customRender: {
          "li": (ctx, child) {
            return customListItem(context, ctx.tree.element!);
          },
          "a": (ctx, child) {
            return customHyperLink(
                context,
                ctx.tree.element!.attributes['href'].toString(),
                ctx.tree.element!);
          },
          "img": (ctx, child) {
            return customImage(context, ctx.tree.element!.attributes);
          }
        },
      ),
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
            decorationColor: Colors.blueAccent,
            fontSize: 16.0),
      ),
    );
  }

  Image customImage(
    BuildContext context,
    LinkedHashMap<Object, String> attributes,
  ) {
    return Image.network(attributes["src"].toString(), scale: 5);
  }

  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}

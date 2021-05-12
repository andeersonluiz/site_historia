import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:site_historia/Components/htmlViewerImage_component.dart';
import 'package:url_launcher/url_launcher.dart';

class HtmlViewer extends StatelessWidget {
  final String content;
  final EdgeInsets margin;
  HtmlViewer(this.content, {this.margin = const EdgeInsets.all(16.0)});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      child: HtmlWidget(
        content,
        textStyle: Theme.of(context).textTheme.headline6!.copyWith(
              color: Theme.of(context).primaryColor,
            ),
        factoryBuilder: () => HtmlImageWidget(),
        hyperlinkColor: Colors.blueAccent,
        onTapUrl: (url) => _launchURL(url),
      ),
    );
  }

  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}

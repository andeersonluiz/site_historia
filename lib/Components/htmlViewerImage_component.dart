import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_cached_network_image/fwfh_cached_network_image.dart';
import 'package:fwfh_webview/fwfh_webview.dart';
import 'package:site_historia/Components/customImage_component.dart';

class HtmlImageWidget extends WidgetFactory
    with CachedNetworkImageFactory, WebViewFactory {
  @override
  Widget? buildImage(BuildMetadata meta, ImageMetadata data) {
    String url = data.sources.first.url;
    return CustomImage(
      fit: BoxFit.contain,
      height: 400,
      image: url,
    );
  }

  @override
  Widget? buildImageWidget(BuildMetadata meta,
      {String? semanticLabel, required String url}) {
    return CustomImage(
      fit: BoxFit.contain,
      height: 400,
      image: url,
    );
  }
}

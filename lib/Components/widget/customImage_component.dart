/// Widget responsável por padronizar a exibição de imagem, de acordo com os parâmetros.
///
/// {@category Component}
/// {@subCategory Widget}
// ignore: library_names
library CustomImage;

import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final double? height;
  final double? width;
  final String image;
  final BoxFit fit;
  final EdgeInsets padding;
  final double circularRadius;
  final EdgeInsetsGeometry? marginContainer;
  final bool isOval;
  CustomImage({
    this.height,
    this.width,
    required this.image,
    this.fit = BoxFit.fill,
    this.padding = const EdgeInsets.all(8.0),
    this.circularRadius = 0.0,
    this.marginContainer,
    this.isOval = false,
  });

  @override
  Widget build(BuildContext context) {
    return !isOval
        ? Container(
            height: height,
            width: width,
            margin: marginContainer,
            child: Padding(
              padding: padding,
              child: circularRadius == 0.0
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(circularRadius),
                      child: FadeInImage.assetNetwork(
                        image: image,
                        fit: fit,
                        placeholder: "placeholder.gif",
                      ),
                    )
                  : FadeInImage.assetNetwork(
                      image: image,
                      fit: fit,
                      placeholder: "placeholder.gif",
                    ),
            ),
          )
        : ClipOval(
            child: FadeInImage.assetNetwork(
            image: image,
            fit: fit,
            placeholder: "placeholder.gif",
          ));
  }
}

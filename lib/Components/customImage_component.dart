import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final double? height;
  final double? width;
  final String image;
  final BoxFit fit;
  final EdgeInsets padding;
  final double circularRadius;
  final EdgeInsetsGeometry? marginContainer;
  CustomImage({
    this.height,
    this.width,
    required this.image,
    this.fit = BoxFit.fill,
    this.padding = const EdgeInsets.all(8.0),
    this.circularRadius = 0.0,
    this.marginContainer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: marginContainer,
      child: Padding(
        padding: padding,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(circularRadius),
          child: FadeInImage.assetNetwork(
            image: image,
            fit: fit,
            placeholder: "placeholder.gif",
          ),
        ),
      ),
    );
  }
}

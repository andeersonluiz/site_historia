import 'package:flutter/material.dart';

class SliderContainer extends StatelessWidget {
  final String title;
  final String subTitle;
  final String image;
  SliderContainer({
    required this.title,
    required this.subTitle,
    required this.image,
  });
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: Image.network(
            image,
            fit: BoxFit.fill,
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            width: double.infinity,
            height: 130,
            color: Theme.of(context).selectedRowColor,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.headline4,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(subTitle,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context).textTheme.subtitle1),
                    )
                  ]),
            ),
          ),
        ),
      ],
    );
  }
}

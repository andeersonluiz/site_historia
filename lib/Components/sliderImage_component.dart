import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class SliderImage extends StatefulWidget {
  @override
  _SliderImageState createState() => _SliderImageState();
}

class _SliderImageState extends State<SliderImage> {
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.blue,
    Colors.orange
  ];
  final List<int> example = [0, 1, 2, 3, 4];
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        CarouselSlider(
          options: CarouselOptions(
              initialPage: 0,
              enableInfiniteScroll: true,
              autoPlay: true,
              aspectRatio: 3,
              viewportFraction: 0.5,
              autoPlayInterval: Duration(seconds: 10),
              autoPlayAnimationDuration: Duration(seconds: 2),
              autoPlayCurve: Curves.fastLinearToSlowEaseIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                setState(() {
                  _current = index;
                });
              }),
          items: example.map((i) {
            return Expanded(
              child: Container(
                alignment: Alignment.bottomLeft,
                width: MediaQuery.of(context).size.width,
                color: colors[i],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Info ${i.toString()}",
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: example.map((i) {
            return Container(
              height: 8,
              width: 8,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == i ? Colors.grey : Colors.black),
            );
          }).toList(),
        )
      ]),
    );
  }
}

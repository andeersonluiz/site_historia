import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:site_historia/Desktop/widget/sliderContainer_desktop.dart';
import 'package:site_historia/firebase/notice_firestore.dart';
import 'package:site_historia/model/notice_model.dart';

class SliderImageMobile extends StatefulWidget {
  @override
  _SliderImageMobileState createState() => _SliderImageMobileState();
}

class _SliderImageMobileState extends State<SliderImageMobile> {
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.blue,
    Colors.orange
  ];
  final List<int> example = [0, 1, 2, 3, 4];
  int _current = 0;
  final noticeFirestore = NoticeFirestore();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [
        FutureBuilder(
            future: noticeFirestore.getSliders(),
            builder: (ctx, snp) {
              if (snp.hasData) {
                final List<Notice> listNotices = snp.data as List<Notice>;
                return width > 600
                    ? CarouselSlider(
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
                        items: listNotices.map((item) {
                          return SliderContainer(
                            notice: item,
                            sizeContainer: 110,
                            maxLinesSubtitle: 1,
                          );
                        }).toList(),
                      )
                    : sliderImageMini(listNotices);
              } else if (snp.hasError) {
                return Container();
              } else {
                return Container(
                  height: 200,
                );
              }
            }),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: example.map((i) {
            return Container(
                height: 8,
                width: 8,
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _current == i
                        ? Theme.of(context).selectedRowColor
                        : Theme.of(context).primaryColor));
          }).toList(),
        )
      ]),
    );
  }

  Widget sliderImageMini(List<Notice> listNotices) {
    return CarouselSlider(
      options: CarouselOptions(
          initialPage: 0,
          enableInfiniteScroll: true,
          autoPlay: true,
          height: 250,
          autoPlayInterval: Duration(seconds: 10),
          autoPlayAnimationDuration: Duration(seconds: 2),
          autoPlayCurve: Curves.fastLinearToSlowEaseIn,
          scrollDirection: Axis.horizontal,
          onPageChanged: (index, reason) {
            setState(() {
              _current = index;
            });
          }),
      items: listNotices.map((item) {
        return SliderContainer(
          notice: item,
          sizeContainer: 110,
          maxLinesSubtitle: 1,
        );
      }).toList(),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/widget/customLoading_component.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Store/notice_store.dart';

import '../../Components/widget/sliderContainer_component.dart';
import '../../Model/notice_model.dart';

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
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final noticeStore = Provider.of<NoticeStore>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Observer(builder: (ctx) {
        noticeStore.listSliders ?? noticeStore.getSliders();
        switch (noticeStore.listSliders!.status) {
          case FutureStatus.pending:
            return CustomLoading();
          case FutureStatus.rejected:
            return ErrorLoad(
              color: Theme.of(context).primaryColor,
            );
          case FutureStatus.fulfilled:
            final List<Notice> listNotices =
                noticeStore.listSliders!.value as List<Notice>;
            final pagination = List.generate(
                noticeStore.listSliders!.value.length, (index) => index);

            return Column(
              children: [
                width > 600
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
                    : sliderImageMini(listNotices),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: pagination.map((i) {
                    return Container(
                        height: 8,
                        width: 8,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: _current == i
                                ? Theme.of(context).selectedRowColor
                                : Theme.of(context).primaryColor));
                  }).toList(),
                )
              ],
            );
        }
      }),
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

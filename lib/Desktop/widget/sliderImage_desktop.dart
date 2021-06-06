/// Widget responsável por exibir o Carousel na página inicial (versão desktop).
///
/// {@category Desktop}
/// {@subCategory Widget}
// ignore: library_names
library SliderImageDesktop;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/widget/customLoading_component.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Store/notice_store.dart';
import 'package:site_historia/Support/routesName_support.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../Components/widget/sliderContainer_component.dart';
import '../../Model/notice_model.dart';

class SliderImageDesktop extends StatefulWidget {
  @override
  _SliderImageDesktopState createState() => _SliderImageDesktopState();
}

/// Carrega todas as notícias através do método `getSliders()` que filtra as notícias com o valor `isTopHeader=true`.
class _SliderImageDesktopState extends State<SliderImageDesktop> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    final noticeStore = Provider.of<NoticeStore>(context);

    return Observer(builder: (ctx) {
      noticeStore.listSliders ?? noticeStore.getSliders();
      switch (noticeStore.listSliders!.status) {
        case FutureStatus.pending:
          return CustomLoading();
        case FutureStatus.rejected:
          return ErrorLoad(
            color: Theme.of(context).primaryColor,
          );
        case FutureStatus.fulfilled:
          final pagination = List.generate(
              noticeStore.listSliders!.value.length, (index) => index);
          final List<Notice> listNotices =
              noticeStore.listSliders!.value as List<Notice>;
          return Column(children: [
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
              items: listNotices.map((item) {
                return InkWell(
                  onTap: () {
                    VxNavigator.of(context).push(Uri(
                        path: RouteNames.NOTICES,
                        queryParameters: {"id": item.id.toString()}));
                  },
                  child: SliderContainer(
                    notice: item,
                    sizeContainer: 130,
                    maxLinesSubtitle: 2,
                  ),
                );
              }).toList(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: pagination.map((i) {
                return Container(
                    height: 8,
                    width: 8,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _current == i
                            ? Theme.of(context).selectedRowColor
                            : Theme.of(context).primaryColor));
              }).toList(),
            )
          ]);
      }
    });
  }
}

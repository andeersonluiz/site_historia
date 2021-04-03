import 'package:flutter/material.dart';
import 'package:site_historia/Desktop/appBar/custtomAppBar_component.dart';
import 'package:site_historia/Components/listPost_component.dart';
import 'package:site_historia/Components/listTeacher_component.dart';
import 'package:site_historia/Components/sliderImage_component.dart';
import 'package:site_historia/Desktop/footer/footer_desktop.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';

class HomePageDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StickyHeader(
        header: CustomAppBar(),
        content: Column(children: [
          SliderImage(),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Ultimas Postagens",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ListPost(),
          Divider(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Professores",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          ListTeacher(),
          Divider(),
          FooterDesktop(),
        ]));
  }
}

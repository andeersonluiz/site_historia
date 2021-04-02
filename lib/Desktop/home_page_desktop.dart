import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Desktop/custtomAppBar_component.dart';
import 'package:site_historia/Components/informations_component.dart';
import 'package:site_historia/Components/listPost_component.dart';
import 'package:site_historia/Components/listTeacher_component.dart';
import 'package:site_historia/Components/sliderImage_component.dart';
import 'package:site_historia/Desktop/footer_desktop.dart';
import 'package:site_historia/Desktop/home_page_desktop.dart';

class HomePageDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(),
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
        Footer(),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:site_historia/Components/informations_component.dart';
import 'package:site_historia/Components/listPost_component.dart';
import 'package:site_historia/Components/listTeacher_component.dart';
import 'package:site_historia/Components/sliderImage_component.dart';
import 'package:site_historia/Mobile/navigation_drawer_component.dart';

class HomePageMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
                  SliderImage(),
                  Divider(),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Ultimas Postagens",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    ),
                  ListPost(),
                  Divider(),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Professoress",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    ),
                  ListTeacher(),
                  Divider(),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Contato",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    ),
                  Information(),
                ],
    );
  }
}
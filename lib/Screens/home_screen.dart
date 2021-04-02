import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Desktop/custtomAppBar_component.dart';
import 'package:site_historia/Components/informations_component.dart';
import 'package:site_historia/Components/listPost_component.dart';
import 'package:site_historia/Components/listTeacher_component.dart';
import 'package:site_historia/Components/sliderImage_component.dart';
import 'package:site_historia/Desktop/home_page_desktop.dart';
import 'package:site_historia/Mobile/home_page_mobile.dart';
import 'package:site_historia/Mobile/navigation_drawer_component.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return ResponsiveBuilder(
      builder: (ctx, sizingInformation) => Scaffold(
        drawer: sizingInformation.isDesktop ? null : NavigationDrawer(),
        appBar: sizingInformation.isDesktop
            ? null
            : AppBar(
                backgroundColor: Colors.white,
                automaticallyImplyLeading: false,
                title: Row(
                  children: [Builder(
                      builder: (ctx) => 
                        IconButton(
                            icon: Icon(
                              Icons.menu,
                              color: Colors.black,
                            ),
                            onPressed: () => Scaffold.of(ctx).openDrawer()),
                      ),
                        Spacer(),
                         Padding(
          padding: const EdgeInsets.all(0.0),
          child: Image.network("https://static.wixstatic.com/media/43f1d7_c9c5188b80f8486da4d8d24099a0c9da~mv2_d_1500_1500_s_2.png/v1/fill/w_416,h_148,al_c,q_85,usm_0.66_1.00_0.01/logo-preto.webp",
          fit:BoxFit.contain,
          height:50 ,
          ),
        ),
                        
                
                ]),
              ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              ScreenTypeLayout(
                  mobile: HomePageMobile(), desktop: HomePageDesktop()),
            ],
          ),
        ),
      ),
    );
  }
}

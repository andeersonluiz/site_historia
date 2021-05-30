import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Components/page/adminAddTeacher_page.dart';
import 'package:site_historia/Desktop/appBar/verticalAppBar_desktop.dart';
import 'package:site_historia/Mobile/drawer/adminNavigation_drawer_component.dart';

class AdminAddTeacherScreen extends StatefulWidget {
  @override
  _AdminAddTeacherScreenState createState() => _AdminAddTeacherScreenState();
}

class _AdminAddTeacherScreenState extends State<AdminAddTeacherScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: (ctx, sizingInformation) => Scaffold(
              drawer:
                  sizingInformation.isDesktop ? null : AdminNavigatorDrawerMobile(),
              appBar: sizingInformation.isDesktop
                  ? null
                  : AppBar(
                      centerTitle: true,
                      title: Text("Adicionar Professor"),
                    ),
              body: ScreenTypeLayout(
                  mobile: AdminAddTeacherPage(),
                  desktop: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          VerticalAppBar(),
                          Expanded(child: AdminAddTeacherPage()),
                        ]),
                  )),
            ));
  }
}

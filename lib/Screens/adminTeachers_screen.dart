import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Desktop/adminTeacher_page_desktop.dart';
import 'package:site_historia/Desktop/appBar/verticalAppBar_desktop.dart';
import 'package:site_historia/Mobile/drawer/adminNavigation_drawer_component.dart';
import 'package:site_historia/Mobile/adminTeacher_page_mobile.dart';
import 'package:site_historia/Support/globals_variables.dart';

class AdminTeachersScreen extends StatefulWidget {
  @override
  _AdminTeachersScreenState createState() => _AdminTeachersScreenState();
}

class _AdminTeachersScreenState extends State<AdminTeachersScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (ctx, sizingInformation) => Scaffold(
        drawer: sizingInformation.isDesktop ? null : AdminNavigatorDrawerMobile(),
        appBar: sizingInformation.isDesktop
            ? null
            : AppBar(
                centerTitle: true,
                title: Text("Ola ${GlobalsVariables.username}!!"),
              ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ScreenTypeLayout(
              mobile: AdminTeacherPageMobile(),
              desktop: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Row(children: [
                  VerticalAppBar(),
                  AdminTeacherPageDesktop(),
                ]),
              )),
        ),
      ),
    );
  }
}

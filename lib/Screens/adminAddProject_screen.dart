import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Desktop/addProject_page_desktop.dart';
import 'package:site_historia/Desktop/appBar/verticalAppBar_desktop.dart';
import '../Mobile/drawer/navigation_drawer_component.dart';

class AdminAddProjectScreen extends StatefulWidget {
  @override
  _AdminAddProjectScreenState createState() => _AdminAddProjectScreenState();
}

class _AdminAddProjectScreenState extends State<AdminAddProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (ctx, sizingInformation) => Scaffold(
        drawer: sizingInformation.isDesktop ? null : NavigationDrawer(),
        appBar: sizingInformation.isDesktop ? null : AppBar(),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ScreenTypeLayout(
              mobile: Container(),
              desktop: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Row(children: [
                  VerticalAppBar(),
                  Expanded(child: AddProjectPage()),
                ]),
              )),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Desktop/adminAddNotice_page_desktop.dart';
import 'package:site_historia/Desktop/appBar/verticalAppBar_desktop.dart';
import 'package:site_historia/Mobile/drawer/adminNavigation_drawer_component.dart';

class AdminAddNoticeScreen extends StatefulWidget {
  @override
  _AdminAddNoticeScreenState createState() => _AdminAddNoticeScreenState();
}

class _AdminAddNoticeScreenState extends State<AdminAddNoticeScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
        builder: (ctx, sizingInformation) => Scaffold(
              drawer:
                  sizingInformation.isDesktop ? null : AdminNavigatorDrawer(),
              appBar: sizingInformation.isDesktop
                  ? null
                  : AppBar(
                      centerTitle: true,
                      title: Text("Adicionar Noticia"),
                    ),
              body: ScreenTypeLayout(
                  mobile: AdminAddNoticePageDesktop(),
                  desktop: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                      VerticalAppBar(),
                      Expanded(child: AdminAddNoticePageDesktop()),
                    ]),
                  )),
            ));
  }
}

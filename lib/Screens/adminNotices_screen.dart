/// Tela responsável por exibir a lista de notícias (Admin).
///
/// {@category Screen}
// ignore: library_names
library AdminNoticesScreen;
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Desktop/adminNotice_page_desktop.dart';
import 'package:site_historia/Desktop/appBar/verticalAppBar_desktop.dart';
import 'package:site_historia/Mobile/adminNotice_page_mobile.dart';
import 'package:site_historia/Mobile/drawer/adminNavigation_drawer_component.dart';
import 'package:site_historia/Support/globals_variables.dart';
/// O Widget redireciona para duas telas diferentes, o desktop conta com o `VerticalAppBar` e a mobile
/// possui `AdminNavigatorDrawerMobile`. Possui um Widget para
/// desktop (`AdminNoticePageDesktop()`) e outro para mobile (`AdminNoticePageMobile()`).
class AdminNoticesScreen extends StatefulWidget {
  @override
  _AdminNoticesScreenState createState() => _AdminNoticesScreenState();
}

class _AdminNoticesScreenState extends State<AdminNoticesScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (ctx, sizingInformation) => Scaffold(
        drawer: sizingInformation.isDesktop ? null : AdminNavigatorDrawerMobile(),
        appBar: sizingInformation.isDesktop
            ? null
            : AppBar(
                centerTitle: true,
                title: Text("Olá, ${GlobalsVariables.username}!!"),
              ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ScreenTypeLayout(
              mobile: AdminNoticePageMobile(),
              desktop: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Row(children: [
                  VerticalAppBar(),
                  AdminNoticePageDesktop(),
                ]),
              )),
        ),
      ),
    );
  }
}

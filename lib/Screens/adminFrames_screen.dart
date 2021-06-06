/// Tela responsável por exibir a lista de quadros (Admin).
///
/// {@category Screen}
// ignore: library_names
library AdminFramesScreen;
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Desktop/adminFrame_page_desktop.dart';
import 'package:site_historia/Desktop/appBar/verticalAppBar_desktop.dart';
import 'package:site_historia/Mobile/adminFrame_page_mobile.dart';
import 'package:site_historia/Mobile/drawer/adminNavigation_drawer_component.dart';
import 'package:site_historia/Support/globals_variables.dart';
/// O Widget redireciona para duas telas diferentes, o desktop conta com o `VerticalAppBar` e a mobile
/// possui `AdminNavigatorDrawerMobile`. Possui um Widget para
/// desktop (`AdminFramePageDesktop()`) e outro para mobile (`AdminFramePageMobile()`).
class AdminFramesScreen extends StatefulWidget {
  @override
  _AdminFramesScreenState createState() => _AdminFramesScreenState();
}

class _AdminFramesScreenState extends State<AdminFramesScreen> {
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
              mobile: AdminFramePageMobile(),
              desktop: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Row(children: [
                  VerticalAppBar(),
                  AdminFramePageDesktop(),
                ]),
              )),
        ),
      ),
    );
  }
}

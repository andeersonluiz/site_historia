/// Tela responsável por exibir a lista de projetos (Admin).
///
/// {@category Screen}
// ignore: library_names
library AdminProjectsScreen;
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Desktop/adminProject_page_desktop.dart';
import 'package:site_historia/Desktop/appBar/verticalAppBar_desktop.dart';
import 'package:site_historia/Mobile/adminProject_page_mobile.dart';
import 'package:site_historia/Mobile/drawer/adminNavigation_drawer_component.dart';
import 'package:site_historia/Support/globals_variables.dart';

/// O Widget redireciona para duas telas diferentes, o desktop conta com o `VerticalAppBar` e a mobile
/// possui `AdminNavigatorDrawerMobile`. Possui um Widget para
/// desktop (`AdminProjectPageDesktop()`) e outro para mobile (`AdminProjectPageMobile()`).
class AdminProjectsScreen extends StatefulWidget {
  @override
  _AdminProjectsScreenState createState() => _AdminProjectsScreenState();
}

class _AdminProjectsScreenState extends State<AdminProjectsScreen> {
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
              mobile: AdminProjectPageMobile(),
              desktop: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Row(children: [
                  VerticalAppBar(),
                  AdminProjectPageDesktop(),
                ]),
              )),
        ),
      ),
    );
  }
}

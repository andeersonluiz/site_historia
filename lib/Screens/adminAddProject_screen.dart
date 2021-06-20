/// Tela responsável por exibir a página de adicionar projeto (Admin).
///
/// {@category Screen}
// ignore: library_names
library AdminAddProjectScreen;
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Desktop/adminAddProject_page_desktop.dart';
import 'package:site_historia/Desktop/appBar/verticalAppBar_desktop.dart';
import 'package:site_historia/Mobile/adminAddProject_page_mobile.dart';
import 'package:site_historia/Mobile/drawer/adminNavigation_drawer_component.dart';

/// O Widget redireciona para duas telas diferentes, o desktop conta com o `VerticalAppBar` e a mobile
/// possui `AdminNavigatorDrawerMobile`. Possui um Widget para
/// desktop (`AdminAddProjectPageDesktop()`) e outro para mobile (`AdminAddProjectPageMobile()`).
class AdminAddProjectScreen extends StatefulWidget {
  @override
  _AdminAddProjectScreenState createState() => _AdminAddProjectScreenState();
}
class _AdminAddProjectScreenState extends State<AdminAddProjectScreen> {
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
                      title: SelectableText("Adicionar Projeto"),
                    ),
              body: ScreenTypeLayout(
                  mobile: AdminAddProjectPageMobile(),
                  desktop: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                      VerticalAppBar(),
                      Expanded(child: AdminAddProjectPageDesktop()),
                    ]),
                  )),
            ));
  }
}

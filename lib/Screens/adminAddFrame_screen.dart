/// Tela responsável por exibir a página de adicionar quadro (Admin).
///
/// {@category Screen}
// ignore: library_names
library AdminAddFrameScreen;
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Components/page/adminAddFrame_page_desktop.dart';
import 'package:site_historia/Desktop/appBar/verticalAppBar_desktop.dart';
import 'package:site_historia/Mobile/drawer/adminNavigation_drawer_component.dart';

/// O Widget redireciona para duas telas diferentes, o desktop conta com o `VerticalAppBar` e a mobile
/// possui `AdminNavigatorDrawerMobile`. Possui um Widget para
/// desktop (`AdminAddFramePageDesktop()`) e outro para mobile (`AdminAddFramePageMobile()`).
class AdminAddFrameScreen extends StatefulWidget {
  @override
  _AdminAddFrameScreenState createState() => _AdminAddFrameScreenState();
}

class _AdminAddFrameScreenState extends State<AdminAddFrameScreen> {
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
                      title: SelectableText("Adicionar Quadro"),
                    ),
              body: ScreenTypeLayout(
                  mobile: AdminAddFramePage(),
                  desktop: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      VerticalAppBar(),
                      Expanded(child: AdminAddFramePage()),
                    ]),
                  )),
            ));
  }
}

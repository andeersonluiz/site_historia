/// Tela responsável por exibir a página as informações de acervo (Admin).
///
/// {@category Screen}
// ignore: library_names
library AdminCollectionScreen;
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Components/page/adminCollection_page.dart';
import 'package:site_historia/Desktop/appBar/verticalAppBar_desktop.dart';
import 'package:site_historia/Mobile/drawer/adminNavigation_drawer_component.dart';
/// O Widget redireciona para duas telas diferentes, o desktop conta com o `VerticalAppBar` e a mobile
/// possui `AdminNavigatorDrawerMobile`.
class AdminCollectionScreen extends StatefulWidget {
  @override
  _AdminCollectionScreenState createState() => _AdminCollectionScreenState();
}

class _AdminCollectionScreenState extends State<AdminCollectionScreen> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (ctx, sizingInformation) => Scaffold(
          drawer: sizingInformation.isDesktop ? null : AdminNavigatorDrawerMobile(),
          appBar: sizingInformation.isDesktop
              ? null
              : AppBar(
                  centerTitle: true,
                  title: Text("Editar Acervo"),
                ),
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ScreenTypeLayout(
                mobile: AdminCollectionPage(),
                desktop: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        VerticalAppBar(),
                        Expanded(child: AdminCollectionPage()),
                      ]),
                )),
          )),
    );
  }
}

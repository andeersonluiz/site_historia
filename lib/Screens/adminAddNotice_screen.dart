/// Tela responsável por exibir a página de adicionar notícia (Admin).
///
/// {@category Screen}
// ignore: library_names
library AdminAddNoticeScreen;
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Components/page/adminAddNotice_page.dart';
import 'package:site_historia/Desktop/appBar/verticalAppBar_desktop.dart';
import 'package:site_historia/Mobile/drawer/adminNavigation_drawer_component.dart';

/// O Widget redireciona para duas telas diferentes, o desktop conta com o `VerticalAppBar` e a mobile
/// possui `AdminNavigatorDrawerMobile`.
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
                  sizingInformation.isDesktop ? null : AdminNavigatorDrawerMobile(),
              appBar: sizingInformation.isDesktop
                  ? null
                  : AppBar(
                      centerTitle: true,
                      title: SelectableText("Adicionar Notícia"),
                    ),
              body: ScreenTypeLayout(
                  mobile: AdminAddNoticePage(),
                  desktop: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,

                        children: [
                      VerticalAppBar(),
                      Expanded(child: AdminAddNoticePage()),
                    ]),
                  )),
            ));
  }
}

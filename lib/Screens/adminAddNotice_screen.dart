import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Components/customLoading_component.dart';
import 'package:site_historia/Desktop/adminAddNotice_page_desktop.dart';
import 'package:site_historia/Desktop/appBar/verticalAppBar_desktop.dart';
import 'package:site_historia/Mobile/adminAddProject_page_mobile.dart';
import 'package:site_historia/Mobile/drawer/adminNavigation_drawer_component.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Store/project_store.dart';

class AdminAddNoticeScreen extends StatefulWidget {
  final String username;
  AdminAddNoticeScreen(this.username);
  @override
  _AdminAddNoticeScreenState createState() => _AdminAddNoticeScreenState();
}

class _AdminAddNoticeScreenState extends State<AdminAddNoticeScreen> {
  @override
  Widget build(BuildContext context) {
    final projectStore = Provider.of<ProjectStore>(context);

    return FutureBuilder(
        future: projectStore.getUsernameByUid(widget.username),
        builder: (ctx, snp) {
          if (snp.hasData) {
            return ResponsiveBuilder(
                builder: (ctx, sizingInformation) => Scaffold(
                      drawer: sizingInformation.isDesktop
                          ? null
                          : AdminNavigatorDrawer(),
                      appBar: sizingInformation.isDesktop
                          ? null
                          : AppBar(
                              centerTitle: true,
                              title: Text("Adicionar Noticia"),
                            ),
                      body: ScreenTypeLayout(
                          mobile: AdminAddProjectPageMobile(),
                          desktop: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Row(children: [
                              VerticalAppBar(),
                              Expanded(child: AdminAddNoticePageDesktop()),
                            ]),
                          )),
                    ));
          } else if (snp.hasError) {
            return ErrorLoad(
              color: Theme.of(context).primaryColor,
            );
          } else {
            return CustomLoading();
          }
        });
  }
}

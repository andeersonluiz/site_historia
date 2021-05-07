import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Components/customLoading_component.dart';
import 'package:site_historia/Desktop/adminNotice_page_desktop.dart';
import 'package:site_historia/Desktop/appBar/verticalAppBar_desktop.dart';
import 'package:site_historia/Mobile/adminNotice_page_mobile.dart';
import 'package:site_historia/Mobile/drawer/adminNavigation_drawer_component.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Store/project_store.dart';

class AdminNoticesScreen extends StatefulWidget {
  final String username;
  AdminNoticesScreen(this.username);
  @override
  _AdminNoticesScreenState createState() => _AdminNoticesScreenState();
}

class _AdminNoticesScreenState extends State<AdminNoticesScreen> {
  @override
  Widget build(BuildContext context) {
    final projectStore = Provider.of<ProjectStore>(context);
    return FutureBuilder(
        future: projectStore.getUsernameByUid(widget.username),
        builder: (ctx, snp) {
          if (snp.hasData) {
            return ResponsiveBuilder(
              builder: (ctx, sizingInformation) => Scaffold(
                drawer:
                    sizingInformation.isDesktop ? null : AdminNavigatorDrawer(),
                appBar: sizingInformation.isDesktop
                    ? null
                    : AppBar(
                        centerTitle: true,
                        title: Text("Ola ${snp.data}!!"),
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

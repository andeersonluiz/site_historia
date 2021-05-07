import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Components/customLoading_component.dart';
import 'package:site_historia/Desktop/adminUpdateProject_page_desktop.dart';
import 'package:site_historia/Desktop/appBar/verticalAppBar_desktop.dart';
import 'package:site_historia/Mobile/adminUpdateProject_page_mobile.dart';
import 'package:site_historia/Mobile/drawer/adminNavigation_drawer_component.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Store/project_store.dart';
import 'package:site_historia/Model/project_model.dart';

class AdminUpdateProjectScreen extends StatefulWidget {
  final Project project;
  final String username;

  AdminUpdateProjectScreen(this.project, this.username);

  @override
  _AdminUpdateProjectScreenState createState() =>
      _AdminUpdateProjectScreenState();
}

class _AdminUpdateProjectScreenState extends State<AdminUpdateProjectScreen> {
  @override
  Widget build(BuildContext context) {
    final projectStore = Provider.of<ProjectStore>(context);
    return ResponsiveBuilder(
      builder: (ctx, sizingInformation) => Scaffold(
          drawer: sizingInformation.isDesktop ? null : AdminNavigatorDrawer(),
          appBar: sizingInformation.isDesktop ? null : AppBar(),
          body: FutureBuilder(
            future: projectStore.getUsernameByUid(widget.username),
            builder: (ctx, snp) {
              if (snp.hasData) {
                return SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: ScreenTypeLayout(
                      mobile: AdminUpdateProjectPageMobile(widget.project),
                      desktop: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: Row(children: [
                          VerticalAppBar(),
                          Expanded(
                              child: AdminUpdateProjectPageDesktop(
                                  widget.project)),
                        ]),
                      )),
                );
              } else if (snp.hasError) {
                return ErrorLoad(
                  color: Theme.of(context).primaryColor,
                );
              } else {
                return CustomLoading();
              }
            },
          )),
    );
  }
}

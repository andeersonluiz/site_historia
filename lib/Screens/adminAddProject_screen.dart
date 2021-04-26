import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Components/customLoading_component.dart';
import 'package:site_historia/Desktop/adminAddProject_page_desktop.dart';
import 'package:site_historia/Desktop/appBar/verticalAppBar_desktop.dart';
import 'package:site_historia/Mobile/adminAddProject_page_mobile.dart';
import 'package:site_historia/Mobile/drawer/adminNavigation_drawer_component.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/firebase/project_firestore.dart';

class AdminAddProjectScreen extends StatefulWidget {
  final String username;
  AdminAddProjectScreen(this.username);
  @override
  _AdminAddProjectScreenState createState() => _AdminAddProjectScreenState();
}

class _AdminAddProjectScreenState extends State<AdminAddProjectScreen> {
  @override
  Widget build(BuildContext context) {
    final projectFirestore = Provider.of<ProjectFirestore>(context);

    return FutureBuilder(
        future: projectFirestore.getUsernameByUid(widget.username),
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
                            title: Text("Adicionar Projeto"),
                          ),
                    body: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: ScreenTypeLayout(
                          mobile: AdminAddProjectPageMobile(),
                          desktop: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height,
                            child: Row(children: [
                              VerticalAppBar(),
                              Expanded(child: AdminAddProjectPageDesktop()),
                            ]),
                          )),
                    )));
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

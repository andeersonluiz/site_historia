import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Components/customLoading_component.dart';
import 'package:site_historia/Desktop/adminListProjects_page_desktop.dart';
import 'package:site_historia/Desktop/appBar/verticalAppBar_desktop.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/firebase/project_firestore.dart';
import '../Mobile/drawer/navigation_drawer_component.dart';

class AdminProjectsScreen extends StatefulWidget {
  final String username;
  AdminProjectsScreen(this.username);
  @override
  _AdminProjectsScreenState createState() => _AdminProjectsScreenState();
}

class _AdminProjectsScreenState extends State<AdminProjectsScreen> {
  @override
  Widget build(BuildContext context) {
    final projectFirestore = Provider.of<ProjectFirestore>(context);

    return ResponsiveBuilder(
      builder: (ctx, sizingInformation) => Scaffold(
        drawer: sizingInformation.isDesktop ? null : NavigationDrawer(),
        appBar: sizingInformation.isDesktop ? null : AppBar(),
        body: FutureBuilder(
          future: projectFirestore.getUsernameByUid(widget.username),
          builder: (ctx, snp) {
            if (snp.hasData) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: ScreenTypeLayout(
                    mobile: Container(),
                    desktop: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      child: Row(children: [
                        VerticalAppBar(),
                        AdminListProjectsPage(),
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
        ),
      ),
    );
  }
}

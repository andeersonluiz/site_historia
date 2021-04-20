import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Desktop/appBar/custtomAppBar_desktop.dart';
import 'package:site_historia/Desktop/project_page_desktop.dart';
import 'package:site_historia/Mobile/project_page_mobile.dart';
import 'package:site_historia/model/project_model.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../Mobile/drawer/navigation_drawer_component.dart';

class ProjectScreen extends StatefulWidget {
  final Project project;
  ProjectScreen(this.project);
  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ResponsiveBuilder(
      builder: (ctx, sizingInformation) => Scaffold(
        endDrawer: sizingInformation.isDesktop ? null : NavigationDrawer(),
        appBar: sizingInformation.isDesktop
            ? null
            : AppBar(automaticallyImplyLeading: false, actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Icon(FontAwesomeIcons.bookOpen, size: 30),
                ),
                Spacer(),
                Builder(
                  builder: (ctx) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        icon: Icon(
                          Icons.menu,
                        ),
                        onPressed: () => Scaffold.of(ctx).openEndDrawer()),
                  ),
                ),
              ]),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: ScreenTypeLayout(
              mobile: width > 600
                  ? ProjectPageDesktop(widget.project)
                  : ProjectPageMobile(widget.project),
              desktop: StickyHeader(
                  header: CustomAppBar(),
                  content: ProjectPageDesktop(widget.project))),
        ),
      ),
    );
  }
}

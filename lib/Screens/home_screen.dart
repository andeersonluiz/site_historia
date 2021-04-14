import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Desktop/appBar/custtomAppBar_desktop.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../Desktop/home_page_desktop.dart';
import '../Mobile/home_page_mobile.dart';
import '../Mobile/drawer/navigation_drawer_component.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
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
              mobile: HomePageMobile(),
              desktop: StickyHeader(
                  header: CustomAppBar(), content: HomePageDesktop())),
        ),
      ),
    );
  }
}

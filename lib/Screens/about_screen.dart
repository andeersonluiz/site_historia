import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Desktop/about_page_desktop.dart';
import 'package:site_historia/Desktop/appBar/custtomAppBar_desktop.dart';
import 'package:site_historia/Mobile/about_page_mobile.dart';
import 'package:site_historia/Support/IconsData_support.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../Mobile/drawer/navigation_drawer_component.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
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
                  child: Icon(IconsData.LOGO_ICON, size: 30),
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
              mobile: AboutPageMobile(),
              desktop: StickyHeader(
                  header: CustomAppBarDesktop(), content: AboutPageDesktop())),
        ),
      ),
    );
  }
}

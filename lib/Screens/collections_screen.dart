import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Components/widget/customLoading_component.dart';
import 'package:site_historia/Desktop/appBar/custtomAppBar_desktop.dart';
import 'package:site_historia/Components/page/collection_page.dart';
import 'package:site_historia/Model/collection_model.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Support/IconsData_support.dart';
import 'package:site_historia/firebase/collection_firestore.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../Mobile/drawer/navigation_drawer_component.dart';

class CollectionScreen extends StatefulWidget {
  @override
  _CollectionScreenState createState() => _CollectionScreenState();
}

class _CollectionScreenState extends State<CollectionScreen> {
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
            body: FutureBuilder(
                future: CollectionFirestore.getCollections(),
                builder: (ctx, snp) {
                  if (snp.hasData) {
                    Collection collection = snp.data as Collection;
                    return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: ScreenTypeLayout(
                          mobile: CollectionPage(collection),
                          desktop: StickyHeader(
                              header: CustomAppBarDesktop(),
                              content: CollectionPage(collection))),
                    );
                  } else if (snp.hasError) {
                    return ErrorLoad(color: Theme.of(context).primaryColor);
                  } else {
                    return CustomLoading();
                  }
                })));
  }
}

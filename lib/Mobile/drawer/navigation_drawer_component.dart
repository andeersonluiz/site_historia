import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/firebase/frame_firestore.dart';
import 'package:site_historia/firebase/project_firestore.dart';

import '../../Support/RoutesName_support.dart';
import 'drawerTitle_subItem.dart';
import 'drawer_item.dart';
import 'drawer_subItem.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProjectFirestore projectFirestore = Provider.of<ProjectFirestore>(context);
    FrameFirestore frameFirestore = Provider.of<FrameFirestore>(context);

    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: ListView(
          children: [
            DrawerHeader(child: Container(height: 100, child: Text('Titleee'))),
            DrawerItem(
              RouteNames.HOME,
              Icons.home,
            ),
            DrawerItem(RouteNames.ABOUT, Icons.auto_stories),
            DrawerItemWithSubItem(
              title: RouteNames.PROJECTS,
              icon: Icons.whatshot_outlined,
              children: projectFirestore.listProjects
                  .map((item) => DrawerSubItem(item, Icons.whatshot_outlined))
                  .toList(),
            ),
            DrawerItem(RouteNames.NOTICES, Icons.cast_for_education),
            DrawerItemWithSubItem(
              title: RouteNames.FRAMES,
              icon: Icons.watch_later_outlined,
              children: frameFirestore.listFrames
                  .map((item) => DrawerSubItem(item, Icons.whatshot_outlined))
                  .toList(),
            ),
            DrawerItem(RouteNames.EXAM, Icons.brush),
            DrawerItem(RouteNames.RECOMENDATIONS, Icons.recommend),
            DrawerItem(RouteNames.COLLECTION, Icons.book),
          ],
        ),
      ),
    );
  }
}

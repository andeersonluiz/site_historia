import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(FontAwesomeIcons.bookOpen),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Coordenação de História',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  ),
                ],
              )),
            ),
            DrawerItem(
              "Inicio",
              RouteNames.HOME,
              Icons.home,
            ),
            DrawerItem("Coordenação de História", RouteNames.ABOUT,
                Icons.auto_stories),
            DrawerItemWithSubItem(
              title: "Projetos",
              icon: Icons.whatshot_outlined,
              children: projectFirestore.listProjectsOrdenedByName
                  .map((item) => DrawerSubItem(
                      item, RouteNames.PROJECTS, Icons.whatshot_outlined))
                  .toList(),
            ),
            DrawerItem(
                "Noticias", RouteNames.NOTICES, Icons.cast_for_education),
            DrawerItemWithSubItem(
              title: "Quadros",
              icon: Icons.watch_later_outlined,
              children: frameFirestore.listFramesOrdenedByName
                  .map((item) => DrawerSubItem(
                      item, RouteNames.FRAMES, Icons.whatshot_outlined))
                  .toList(),
            ),
            DrawerItem("Vestibular", RouteNames.EXAM, Icons.brush),
            DrawerItem(
                "Recomendações", RouteNames.RECOMENDATIONS, Icons.recommend),
            DrawerItem("Acervo", RouteNames.COLLECTION, Icons.book),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Store/project_store.dart';
import 'package:site_historia/Support/IconsData_support.dart';
import 'package:site_historia/firebase/frame_firestore.dart';

import '../../Support/RoutesName_support.dart';
import 'drawerTitle_subItem.dart';
import 'drawer_item.dart';
import 'drawer_subItem.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProjectStore projectStore = Provider.of<ProjectStore>(context);
    FrameFirestore frameFirestore = Provider.of<FrameFirestore>(context);

    return Drawer(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(IconsData.LOGO_ICON),
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
              Divider(
                height: 8,
                thickness: 1.0,
              ),
              DrawerItem(
                "Inicio",
                RouteNames.HOME,
                IconsData.HOME_ICON,
              ),
              DrawerItem("Coordenação de História", RouteNames.ABOUT,
                  IconsData.COORD_ICON),
              DrawerItemWithSubItem(
                title: "Projetos",
                icon: IconsData.PROJECT_ICON,
                children: projectStore.listProjectsOrdened
                    .map((item) => DrawerSubItem(
                        item, RouteNames.PROJECTS, IconsData.PROJECT_ICON))
                    .toList(),
              ),
              DrawerItem("Noticias", RouteNames.NOTICES, IconsData.NOTICE_ICON),
              DrawerItemWithSubItem(
                title: "Quadros",
                icon: IconsData.FRAMES_ICON,
                children: frameFirestore.listFramesOrdenedByName
                    .map((item) => DrawerSubItem(
                        item, RouteNames.FRAMES, IconsData.FRAMES_ICON))
                    .toList(),
              ),
              DrawerItem("Vestibular", RouteNames.EXAM, IconsData.EXAM_ICON),
              DrawerItem("Recomendações", RouteNames.RECOMENDATIONS,
                  IconsData.RECOMENDATION_ICON),
              DrawerItem(
                  "Acervo", RouteNames.COLLECTION, IconsData.COLLECTION_ICON),
            ],
          ),
        ),
      ),
    );
  }
}

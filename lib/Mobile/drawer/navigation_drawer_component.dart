import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Store/frame_store.dart';
import 'package:site_historia/Store/project_store.dart';
import 'package:site_historia/Support/IconsData_support.dart';

import '../../Support/routesName_support.dart';
import 'drawerTitle_subItem.dart';
import 'drawer_item.dart';
import 'drawer_subItem.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProjectStore projectStore = Provider.of<ProjectStore>(context);
    FrameStore frameStore = Provider.of<FrameStore>(context);

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
              DrawerItemMobile(
                "Inicio",
                RouteNames.HOME,
                IconsData.HOME_ICON,
              ),
              DrawerItemMobile("Coordenação de História", RouteNames.ABOUT,
                  IconsData.COORD_ICON),
              DrawerItemWithSubItemMobile(
                title: "Projetos",
                icon: IconsData.PROJECT_ICON,
                children: projectStore.listProjectsOrdered
                    .map((item) => DrawerSubItemMobile(
                        item, RouteNames.PROJECTS, IconsData.PROJECT_ICON))
                    .toList(),
              ),
              DrawerItemMobile("Notícias", RouteNames.NOTICES, IconsData.NOTICE_ICON),
              DrawerItemWithSubItemMobile(
                title: "Quadros",
                icon: IconsData.FRAMES_ICON,
                children: frameStore.listFramesOrdered
                    .map((item) => DrawerSubItemMobile(
                        item, RouteNames.FRAMES, IconsData.FRAMES_ICON))
                    .toList(),
              ),
              DrawerItemMobile("Vestibular", RouteNames.EXAM, IconsData.EXAM_ICON),
              DrawerItemMobile("Recomendações", RouteNames.RECOMMENDATIONS,
                  IconsData.RECOMENDATION_ICON),
              DrawerItemMobile(
                  "Acervo", RouteNames.COLLECTION, IconsData.COLLECTION_ICON),
            ],
          ),
        ),
      ),
    );
  }
}

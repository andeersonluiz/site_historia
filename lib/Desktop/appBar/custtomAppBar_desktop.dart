/// Widget responsável por exibir menu do site.
///
/// {@category Desktop}
/// {@subCategory Drawer}
// ignore: library_names
library CustomAppBarDesktop;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Store/frame_store.dart';
import 'package:site_historia/Store/project_store.dart';
import 'package:site_historia/Support/IconsData_support.dart';

import '../../Support/routesName_support.dart';
import 'itemAppBar_desktop.dart';
import 'itemPopupMenuAppBar_desktop.dart';

/// Exibe o menu do site que é composto pelo widget `ItemAppBarDesktop()` e o `ItemPopUpMenuAppBarDesktop()`.
class CustomAppBarDesktop extends StatefulWidget {
  @override
  _CustomAppBarDesktopState createState() => _CustomAppBarDesktopState();
}

class _CustomAppBarDesktopState extends State<CustomAppBarDesktop> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    ProjectStore projectStore = Provider.of<ProjectStore>(context);
    FrameStore frameStore = Provider.of<FrameStore>(context);

    return Container(
      height: 60.0,
      width: width,
      decoration:
          BoxDecoration(color: Theme.of(context).primaryColor, boxShadow: [
        BoxShadow(
            color: Theme.of(context).primaryColor,
            offset: Offset(0.0, 0.5),
            blurRadius: 3)
      ]),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(IconsData.LOGO_ICON, size: 30),
          ),
          Spacer(),
          ItemAppBarDesktop("Inicio", RouteNames.HOME),
          ItemAppBarDesktop("Coordenação de História", RouteNames.ABOUT),
          ItemPopUpMenuAppBarDesktop(
            "Projetos",
            RouteNames.PROJECTS,
            projectStore.listProjectsOrdered,
          ),
          ItemAppBarDesktop("Notícias", RouteNames.NOTICES),
          ItemPopUpMenuAppBarDesktop(
              "Quadros", RouteNames.FRAMES, frameStore.listFramesOrdered),
          //ItemAppBarDesktop("Vestibular", RouteNames.EXAM),
          ItemAppBarDesktop("Recomendações", RouteNames.RECOMMENDATIONS),
          ItemAppBarDesktop("Acervo", RouteNames.COLLECTION),
        ],
      ),
    );
  }
}

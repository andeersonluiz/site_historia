import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Store/frame_store.dart';
import 'package:site_historia/Store/project_store.dart';
import 'package:site_historia/Support/IconsData_support.dart';

import '../../Support/RoutesName_support.dart';
import 'itemAppBar_desktop.dart';
import 'itemPopupMenuAppBar_desktop.dart';

class CustomAppBar extends StatefulWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
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
          ItemAppBar("Inicio", RouteNames.HOME),
          ItemAppBar("Coordenação de História", RouteNames.ABOUT),
          ItemPopUpMenuAppBar(
            "Projetos",
            RouteNames.PROJECTS,
            projectStore.listProjectsOrdered,
          ),
          ItemAppBar("Notícias", RouteNames.NOTICES),
          ItemPopUpMenuAppBar(
              "Quadros", RouteNames.FRAMES, frameStore.listFramesOrdered),
          ItemAppBar("Vestibular", RouteNames.EXAM),
          ItemAppBar("Recomendações", RouteNames.RECOMMENDATIONS),
          ItemAppBar("Acervo", RouteNames.COLLECTION),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../Support/RoutesName_support.dart';
import '../../firebase/frame_firestore.dart';
import '../../firebase/project_firestore.dart';
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
    ProjectFirestore projectFirestore = Provider.of<ProjectFirestore>(context);
    FrameFirestore frameFirestore = Provider.of<FrameFirestore>(context);

    return Container(
      height: 70,
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
            child: Icon(FontAwesomeIcons.bookOpen, size: 30),
          ),
          Spacer(),
          ItemAppBar("Inicio", RouteNames.HOME),
          ItemAppBar("Coordenação de História", RouteNames.ABOUT),
          ItemPopUpMenuAppBar(
            "Projetos",
            RouteNames.PROJECTS,
            projectFirestore.listProjectsOrdenedByName,
          ),
          ItemAppBar("Noticias", RouteNames.NOTICES),
          ItemPopUpMenuAppBar("Quadros", RouteNames.FRAMES,
              frameFirestore.listFramesOrdenedByName),
          ItemAppBar("Vestibular", RouteNames.EXAM),
          ItemAppBar("Recomendações", RouteNames.RECOMENDATIONS),
          ItemAppBar("Acervo", RouteNames.COLLECTION),
        ],
      ),
    );
  }
}

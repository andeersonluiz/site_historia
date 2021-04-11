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
  bool open = false;
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
          ItemAppBar(RouteNames.HOME, () {}),
          ItemAppBar(RouteNames.ABOUT, () {}),
          ItemPopUpMenuAppBar(
              RouteNames.PROJECTS, projectFirestore.listProjects),
          ItemAppBar(RouteNames.NOTICES, () {}),
          ItemPopUpMenuAppBar(RouteNames.FRAMES, frameFirestore.listFrames),
          ItemAppBar(RouteNames.EXAM, () {}),
          ItemAppBar(RouteNames.RECOMENDATIONS, () {}),
          ItemAppBar(RouteNames.COLLECTION, () {}),
        ],
      ),
    );
  }

  showMenus(BuildContext context) async {
    await showMenu(
            context: context,
            position: RelativeRect.fromLTRB(0, 45, 0, 0),
            color: Colors.red,
            items: ['aaa', 'afasd', 'dasdpa']
                .map((e) => PopupMenuItem(child: Text(e), value: e))
                .toList())
        .then((value) {
      if (value == null) {
        setState(() {
          open = false;
        });
      } else {
        open = true;
      }
    });
  }
}

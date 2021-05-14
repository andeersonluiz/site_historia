import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:site_historia/Desktop/appBar/verticalItem_desktop.dart';
import 'package:site_historia/Support/IconsData_support.dart';
import 'package:site_historia/Support/RoutesName_support.dart';
import 'package:site_historia/Support/globals_variables.dart';

class VerticalAppBarMax extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24.0),
          child: Text(
            "Ola ${GlobalsVariables.username}!",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Divider(
          height: 0,
          color: Theme.of(context).iconTheme.color,
        ),
        VerticalItem(
            "Projetos", RouteNames.ADMIN_PROJECTS, IconsData.PROJECT_ICON),
        Divider(
          height: 0,
          color: Theme.of(context).iconTheme.color,
        ),
        VerticalItem(
            "Notícias", RouteNames.ADMIN_NOTICES, IconsData.NOTICE_ICON),
        Divider(
          height: 0,
          color: Theme.of(context).iconTheme.color,
        ),
        VerticalItem("Quadros", RouteNames.ADMIN_FRAMES, IconsData.FRAMES_ICON),
        Divider(
          height: 0,
          color: Theme.of(context).iconTheme.color,
        ),
        VerticalItem("Professores", "", IconsData.TEACHER_ICON),
        Divider(
          height: 0,
          color: Theme.of(context).iconTheme.color,
        ),
        VerticalItem("Acervo", "", IconsData.COLLECTION_ICON),
        Divider(
          height: 0,
          color: Theme.of(context).iconTheme.color,
        ),
        VerticalItem(
          "Sair",
          RouteNames.ADMIN,
          FontAwesomeIcons.signOutAlt,
        ),
      ],
    );
  }
}

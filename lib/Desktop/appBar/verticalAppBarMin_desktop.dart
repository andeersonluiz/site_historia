import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:site_historia/Desktop/appBar/verticalItem_desktop.dart';
import 'package:site_historia/Support/IconsData_support.dart';
import 'package:site_historia/Support/RoutesName_support.dart';

class VerticalAppBarMin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Icon(IconsData.LOGO_ICON, size: 30),
          ),
          Divider(
            height: 0,
            color: Theme.of(context).iconTheme.color,
          ),
          VerticalItem(
            "Projetos",
            RouteNames.ADMIN_PROJECTS,
            IconsData.PROJECT_ICON,
            isMini: true,
          ),
          Divider(
            height: 0,
            color: Theme.of(context).iconTheme.color,
          ),
          VerticalItem(
            "Noticias",
            RouteNames.ADMIN_NOTICES,
            IconsData.NOTICE_ICON,
            isMini: true,
          ),
          Divider(
            height: 0,
            color: Theme.of(context).iconTheme.color,
          ),
          VerticalItem(
            "Professores",
            "",
            IconsData.TEACHER_ICON,
            isMini: true,
          ),
          Divider(
            height: 0,
            color: Theme.of(context).iconTheme.color,
          ),
          VerticalItem(
            "Acervo",
            "",
            IconsData.COLLECTION_ICON,
            isMini: true,
          ),
          Divider(
            height: 0,
            color: Theme.of(context).iconTheme.color,
          ),
          VerticalItem(
            "Sair",
            RouteNames.ADMIN,
            FontAwesomeIcons.signOutAlt,
            isMini: true,
          ),
          Divider(
            height: 0,
            color: Theme.of(context).iconTheme.color,
          ),
        ],
      ),
    );
  }
}

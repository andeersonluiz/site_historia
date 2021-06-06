/// Widget responsável o menu vertical na página do Admin, versão reduzida (apenas ícones).
///
/// {@category Desktop}
/// {@subCategory Drawer}
// ignore: library_names
library VerticalAppBarMinDesktop;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:site_historia/Desktop/appBar/verticalItem_desktop.dart';
import 'package:site_historia/Support/IconsData_support.dart';
import 'package:site_historia/Support/routesName_support.dart';

/// Exibe o menu vertical que é composto pelo widget `VerticalItemDesktop()` com `isMini = true`.
class VerticalAppBarMinDesktop extends StatelessWidget {
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
          VerticalItemDesktop(
            "Projetos",
            RouteNames.ADMIN_PROJECTS,
            IconsData.PROJECT_ICON,
            isMini: true,
          ),
          Divider(
            height: 0,
            color: Theme.of(context).iconTheme.color,
          ),
          VerticalItemDesktop(
            "Notícias",
            RouteNames.ADMIN_NOTICES,
            IconsData.NOTICE_ICON,
            isMini: true,
          ),
          Divider(
            height: 0,
            color: Theme.of(context).iconTheme.color,
          ),
          VerticalItemDesktop(
            "Professores",
            RouteNames.ADMIN_TEACHERS,
            IconsData.TEACHER_ICON,
            isMini: true,
          ),
          Divider(
            height: 0,
            color: Theme.of(context).iconTheme.color,
          ),
          VerticalItemDesktop(
            "Recomendations",
            RouteNames.ADMIN_RECOMMENDATIONS,
            IconsData.COLLECTION_ICON,
            isMini: true,
          ),
          Divider(
            height: 0,
            color: Theme.of(context).iconTheme.color,
          ),
          VerticalItemDesktop(
            "Acervo",
            RouteNames.ADMIN_COLLECTIONS,
            IconsData.COLLECTION_ICON,
            isMini: true,
          ),
          Divider(
            height: 0,
            color: Theme.of(context).iconTheme.color,
          ),
          VerticalItemDesktop(
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

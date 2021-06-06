/// Widget responsável por exibir o drawer da página de Admin.
///
/// {@category Mobile}
/// {@subCategory Drawer}
// ignore: library_names
library AdminNavigatorDrawerMobile;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:site_historia/Support/IconsData_support.dart';
import 'package:site_historia/Support/routesName_support.dart';
import 'package:site_historia/Mobile/drawer/admin_drawer_item.dart';

/// Exibe o drawer que é composto pelo widget `AdminDrawerItemMobile()`.
class AdminNavigatorDrawerMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PointerInterceptor(
      child: Drawer(
        child: Container(
          width: MediaQuery.of(context).size.width,
          color: Theme.of(context).primaryColor,
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
                      child: Icon(FontAwesomeIcons.userCog),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Area do Admin',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                  ],
                )),
              ),
              Divider(height: 8, thickness: 1.0),
              AdminDrawerItemMobile("Projetos", RouteNames.ADMIN_PROJECTS,
                  IconsData.PROJECT_ICON),
              AdminDrawerItemMobile(
                  "Notícias", RouteNames.ADMIN_NOTICES, IconsData.NOTICE_ICON),
              AdminDrawerItemMobile(
                  "Quadros", RouteNames.ADMIN_FRAMES, IconsData.NOTICE_ICON),
              AdminDrawerItemMobile("Professores", RouteNames.ADMIN_TEACHERS,
                  IconsData.TEACHER_ICON),
              AdminDrawerItemMobile("Recomendações", RouteNames.ADMIN_RECOMMENDATIONS,
                  IconsData.RECOMMENDATION_ICON),
              AdminDrawerItemMobile("Acervo", RouteNames.ADMIN_COLLECTIONS,
                  IconsData.COLLECTION_ICON),
              AdminDrawerItemMobile("Sair", RouteNames.ADMIN, IconsData.LOGOUT_ICON),
            ],
          ),
        ),
      ),
    );
  }
}

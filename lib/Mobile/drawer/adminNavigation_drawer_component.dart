import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:site_historia/Support/IconsData_support.dart';
import 'package:site_historia/Support/RoutesName_support.dart';
import 'package:site_historia/Mobile/drawer/admin_drawer_item.dart';

class AdminNavigatorDrawer extends StatelessWidget {
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
              AdminDrawerItem("Projetos", RouteNames.ADMIN_PROJECTS,
                  IconsData.PROJECT_ICON),
              AdminDrawerItem(
                  "Noticias", RouteNames.ADMIN_NOTICES, IconsData.NOTICE_ICON),
              AdminDrawerItem("Professores", RouteNames.ADMIN_PROJECTS,
                  IconsData.TEACHER_ICON),
              AdminDrawerItem("Acervo", RouteNames.ADMIN_PROJECTS,
                  IconsData.COLLECTION_ICON),
              AdminDrawerItem("Sair", RouteNames.ADMIN, IconsData.LOGOUT_ICON),
            ],
          ),
        ),
      ),
    );
  }
}

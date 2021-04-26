import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:site_historia/Mobile/drawer/drawer_item.dart';
import 'package:site_historia/Support/RoutesName_support.dart';

class AdminNavigatorDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            DrawerItem(
                "Projetos", RouteNames.ADMIN_INFO, Icons.whatshot_outlined),
            DrawerItem(
                "Noticias", RouteNames.ADMIN_INFO, Icons.cast_for_education),
            DrawerItem(
                "Professores", RouteNames.ADMIN_INFO, Icons.theater_comedy),
            DrawerItem("Acervo", RouteNames.ADMIN_INFO, Icons.book),
          ],
        ),
      ),
    );
  }
}

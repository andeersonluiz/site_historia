import 'package:flutter/material.dart';
import 'package:site_historia/Mobile/drawer_item.dart';
import 'package:site_historia/Mobile/drawer_subItem.dart';

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: ListView(
        children: [
          DrawerHeader(child: Center(child: Text('Titleee'))),
          DrawerItem(
            'Inicio',
            Icons.home,
          ),
          DrawerItem('Coordenação de História', Icons.auto_stories),
          ExpansionTile(
            leading: Icon(Icons.whatshot_outlined),
            title: Text('Projetos'),
            children: [
              DrawerSubItem('Projeto 1', Icons.whatshot_outlined),
              DrawerSubItem('Projeto 2', Icons.whatshot_outlined),
              DrawerSubItem('Projeto 3', Icons.whatshot_outlined)
            ],
          ),
          DrawerItem('Noticias', Icons.cast_for_education),
          ExpansionTile(title: Text('Quadros'),
            leading: Icon(Icons.watch_later_outlined),
            children: [
              DrawerSubItem('Quadro 1', Icons.whatshot_outlined),
              DrawerSubItem('Quadro 2', Icons.whatshot_outlined),
              DrawerSubItem('Quadro 3', Icons.whatshot_outlined)
            ],
          ),
          DrawerItem('Vestibular', Icons.brush),
          DrawerItem('Recomendações', Icons.recommend),
          DrawerItem('Acervo', Icons.book),
        ],
      ),
    );
  }
}

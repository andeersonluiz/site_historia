import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:site_historia/Desktop/appBar/itemAppBar_desktop.dart';
import 'package:site_historia/Desktop/appBar/itemPopupMenuAppBar_desktop.dart';

class CustomAppBar extends StatefulWidget {
  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  bool open = false;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
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
          ItemAppBar('Inicio', () {}),
          ItemAppBar('Coordenação de História', () {}),
          ItemPopUpMenuAppBar('Projetos',
              ['Projeto 1123 12312312asdsa', 'Projeto 2', 'Projeto 3']),
          ItemAppBar('Noticias', () {}),
          ItemPopUpMenuAppBar('Quadros', ['Quadro 1', 'Quadro 2', 'Quadro 3']),
          ItemAppBar('Vestibular', () {}),
          ItemAppBar('Recomendações', () {}),
          ItemAppBar('Acervo', () {}),
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

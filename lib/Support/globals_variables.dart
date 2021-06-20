/// Classe responsável pelas variáveis globais do projeto.
///
/// {@category Support}
// ignore: library_names
library GlobalsVariables;

import 'package:firebase/firebase.dart';
import 'package:flutter/material.dart';

class GlobalsVariables {
  static String username = "";
  static int sizeCarousel = 5;
  static String srcDefaultImage = "https://firebasestorage.googleapis.com/v0/b/sitehistoria-439a7.appspot.com/o/defaultImage%2Fsem-imagem-avatar.png?alt=media&token=ab2353f8-42a6-4269-a84c-d2ad52246313";
  static Map<String, Color> colorByTag = {};

  static List<String> types = [
    'Podcast',
    'Noticia',
  ];

  static List<String> tags = [];

  static List<String> filters = [
    'Tudo',
    'Podcast',
    'Estudo',
  ];

  static int maxCharactersTitle = 100;
  static int maxCharactersSubTitle = 100;

  static loadTags() async {
    var query = await firestore().collection("tags").get();
    query.docs.forEach((e) {
      var value = e.data();
      colorByTag[value["name"]] = hexToColor(value["color"]);
      tags.add(value["name"]+"x");
    }
    );
  }

  static Color hexToColor(String hexString, {String alphaChannel = 'FF'}) {
    return Color(int.parse(hexString.replaceFirst('#', '0x$alphaChannel')));
  }
}

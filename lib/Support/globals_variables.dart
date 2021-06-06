/// Classe responsável pelas variáveis globais do projeto.
///
/// {@category Support}
// ignore: library_names
library GlobalsVariables;

import 'package:flutter/material.dart';

class GlobalsVariables {
  static String username = "";
  static int sizeCarousel = 5;
  static Map<String, Color> colorByTag = {
    'Podcast': Colors.green,
    'Estudo': Colors.red,
  };

  static List<String> types = [
    'Podcast',
    'Noticia',
  ];

  static List<String> tags = [
    'Podcast',
    'Estudo',
  ];

  static List<String> filters = [
    'Tudo',
    'Podcast',
    'Estudo',
  ];

  static int maxCharactersTitle = 50;
  static int maxCharactersSubTitle = 100;
}

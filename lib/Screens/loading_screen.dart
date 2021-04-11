import 'package:flutter/material.dart';
import 'package:site_historia/Theme/ThemeConfig.dart';

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: ThemeConfig.brown,
        child: Center(
            child: Image.asset(
          "assets/loading.gif",
          width: 150,
          height: 150,
        )));
  }
}

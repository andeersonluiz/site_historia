import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ErrorLoad extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(FontAwesomeIcons.frown, size: 100),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Erro ao conectar ao banco dados, tente novamente mais tarde",
              style: Theme.of(context).textTheme.headline6!,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

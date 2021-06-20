/// Tela responsável por exibir a página de erro.
///
/// {@category Screen}
// ignore: library_names
library ErrorLoad;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// Exibe a tela de erro quando um carregamento de dados não ocorre com sucesso.
class ErrorLoad extends StatelessWidget {
  final color;
  ErrorLoad({required this.color});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              FontAwesomeIcons.frown,
              size: 100,
              color: color,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SelectableText(
              "Erro ao conectar ao banco dados, tente novamente mais tarde",
              style:
                  Theme.of(context).textTheme.headline6!.copyWith(color: color),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget responsável por padronizar a exibição de informações do autor.
///
/// {@category Component}
/// {@subCategory Widget}
// ignore: library_names
library AuthorInfo;

import 'package:flutter/material.dart';

class AuthorInfo extends StatelessWidget {
  /// Exibe o nome do autor.
  final String author;
  /// Exibe a data de postagem.
  final String datePost;
  AuthorInfo({required this.author, required this.datePost});

  @override
  Widget build(BuildContext context) {
    return MediaQuery.of(context).size.width>600?Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
          child: Text(
            "Autor: $author",
            style: Theme.of(context).textTheme.caption!.copyWith(
                color: Theme.of(context).primaryColor,
                fontStyle: FontStyle.italic),
          ),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
          child: Text(
            "Última atualização: $datePost",
            style: Theme.of(context).textTheme.caption!.copyWith(
                color: Theme.of(context).primaryColor,
                fontStyle: FontStyle.italic),
          ),
        ),
      ],
    ):Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
          child: Text(
            "Autor: $author",
            style: Theme.of(context).textTheme.caption!.copyWith(
                color: Theme.of(context).primaryColor,
                fontStyle: FontStyle.italic),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
          child: Text(
            "Última atualização: $datePost",
            style: Theme.of(context).textTheme.caption!.copyWith(
                color: Theme.of(context).primaryColor,
                fontStyle: FontStyle.italic),
          ),
        ),
      ],
    );
  }
}

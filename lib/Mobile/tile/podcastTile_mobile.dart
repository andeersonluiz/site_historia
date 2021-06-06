/// Widget responsável por exibir informações de podcast na página inicial (versão mobile).
///
/// {@category Mobile}
/// {@subCategory Tile}
// ignore: library_names
library PodcastTileMobile;

import 'package:flutter/material.dart';
import 'package:site_historia/Components/widget/customImage_component.dart';
import 'package:site_historia/Support/globals_variables.dart';
import '../../Model/notice_model.dart';

/// É feita a montagem de informações do podcast, onde recebe o objeto `Notice` que contém informações como:
/// título e subtítulo do podcast e imagem, também possui o parâmetro `widthPercentage` que define a largura
/// do Container onde os dados estão inseridos.
class PodcastTileMobile extends StatelessWidget {
  final Notice podcast;
  final widthPercentage;
  PodcastTileMobile(this.podcast, this.widthPercentage);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width * widthPercentage,
      height: 120,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              flex: 4,
              child: CustomImage(
                height: 150,
                image: podcast.thumb,
                circularRadius: 8.0,
                padding: EdgeInsets.zero,
              )),
          Expanded(
            flex: 6,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: GlobalsVariables.colorByTag[podcast.tag],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(podcast.tag,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Theme.of(context).primaryColor)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      podcast.title,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        podcast.datePost,
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2!
                            .copyWith(color: Theme.of(context).primaryColor),
                      )),
                ]),
          )
        ],
      ),
    );
  }
}

/// Widget responsável por exibir informações de podcast na página inicial (versão desktop).
///
/// {@category Desktop}
/// {@subCategory Tile}
// ignore: library_names
library PodcastTileDesktop;
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:site_historia/Components/widget/customImage_component.dart';
import 'package:site_historia/Support/globals_variables.dart';
import '../../Model/notice_model.dart';

/// É feita a montagem de informações do podcast, onde recebe o objeto `Notice` que contém informações como:
/// título e subtítulo do podcast e imagem, também possui o parâmetro `widthPercentage` que define a largura
/// do Container onde os dados estão inseridos.
class PodcastTileDesktop extends StatelessWidget {
  final Notice podcast;
  PodcastTileDesktop(this.podcast);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 152,
      width: MediaQuery.of(context).size.width * 0.45,
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
                flex: 3,
                child: CustomImage(
                    height: 1,
                      image: podcast.thumb,
                      circularRadius: 8.0,
                      padding: EdgeInsets.zero,
                      fit:BoxFit.fill
                )),
            Expanded(
              flex: 7,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(6.0),
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
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Theme.of(context).primaryColor).copyWith(fontSize: 18),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(7.0),
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
      ),
    );
  }
}

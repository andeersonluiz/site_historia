/// Widget responsável por exibir informações da postagem na página inicial (versão desktop).
///
/// {@category Desktop}
/// {@subCategory Tile}
// ignore: library_names
library PostTileDesktop;

import 'package:flutter/material.dart';
import 'package:site_historia/Components/widget/customImage_component.dart';
import 'package:site_historia/Support/globals_variables.dart';

import '../../Model/notice_model.dart';

/// É feita a montagem de informações do postagem, onde recebe o objeto `Notice` que contém informações como:
/// título e subtítulo do postagem e imagem, também possui o parâmetro `widthPercentage` que define a largura
/// do Container onde os dados estão inseridos.
class PostTileDesktop extends StatelessWidget {
  final Notice notice;
  PostTileDesktop(this.notice);

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
                  image: notice.thumb,
                  circularRadius: 8.0,
                  padding: EdgeInsets.zero, fit:BoxFit.fill
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
                          color: GlobalsVariables.colorByTag[notice.tag],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          notice.tag,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText2!
                              .copyWith(color: Theme.of(context).primaryColor),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        notice.title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(color: Theme.of(context).primaryColor).copyWith(fontSize: 18),
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          notice.datePost,
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

/// Widget responsável por exibir informações da postagem na página inicial (versão mobile).
///
/// {@category Mobile}
/// {@subCategory Tile}
// ignore: library_names
library PostTileMobile;

import 'package:flutter/material.dart';
import 'package:site_historia/Components/widget/customImage_component.dart';
import 'package:site_historia/Support/globals_variables.dart';

import '../../Model/notice_model.dart';

/// É feita a montagem de informações do postagem, onde recebe o objeto `Notice` que contém informações como:
/// título e subtítulo do postagem e imagem, também possui o parâmetro `widthPercentage` que define a largura
/// do Container onde os dados estão inseridos.
class PostTileMobile extends StatelessWidget {
  final Notice notice;
  final double widthPercentage;
  PostTileMobile(this.notice, this.widthPercentage);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.all(16.0),
        width: MediaQuery.of(context).size.width * widthPercentage,
        height: 150,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  flex: 4,
                  child: CustomImage(
                    image: notice.thumb,
                    circularRadius: 8.0,
                    padding: EdgeInsets.zero,
                  )),
              Expanded(
                flex: 6,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.all(4.0),
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
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(color: Theme.of(context).primaryColor).copyWith(fontSize: 17.5),
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
        ));
  }
}

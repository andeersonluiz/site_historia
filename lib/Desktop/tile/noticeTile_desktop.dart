/// Widget responsável por exibir informações de notícia (versão desktop).
///
/// {@category Component}
/// {@subCategory Tile}
// ignore: library_names
library NoticeTileDesktop;

import 'package:flutter/material.dart';
import 'package:site_historia/Components/widget/customImage_component.dart';
import 'package:site_historia/Components/widget/customText_component.dart';
import 'package:site_historia/Model/notice_model.dart';
import 'package:site_historia/Support/routesName_support.dart';
import 'package:velocity_x/velocity_x.dart';

/// Recebe um objeto `Notice`, que exibe sua imagem, título, subtítulo e data de postagem.
class NoticeTileDesktop extends StatelessWidget {
  final Notice notice;
  NoticeTileDesktop(this.notice);

  @override
  Widget build(BuildContext context) {
    final _onTap = () {
      return VxNavigator.of(context).push(Uri(
          path: RouteNames.NOTICES,
          queryParameters: {"id": notice.id.toString()}));
    };
    final datePost = notice.datePost.split(" ");
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: InkWell(
                onTap: _onTap,
                child: CustomImage(
                  height: 200,
                  image: notice.thumb,
                  fit: BoxFit.contain,
                )),
          ),
          Expanded(
            flex: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 18.0,
                  ),
                  child: InkWell(
                      onTap: _onTap,
                      splashColor: Colors.transparent,
                      child: CustomText(notice.title,

                          style: Theme.of(context).textTheme.headline5)),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: _onTap,
                      splashColor: Colors.transparent,
                      child: CustomText(
                        notice.subtitle,
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.subtitle1,
                      )),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 18.0,
                  ),
                  child: CustomText(
                    "Publicado dia ${datePost[0]} ás ${datePost[1]}",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

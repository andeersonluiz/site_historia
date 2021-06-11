/// Widget responsável por exibir informações de notícia (versão mobile).
///
/// {@category Component}
/// {@subCategory Tile}
// ignore: library_names
library NoticeTileMobile;

import 'package:flutter/material.dart';
import 'package:site_historia/Components/widget/customImage_component.dart';
import 'package:site_historia/Components/widget/customText_component.dart';
import 'package:site_historia/Model/notice_model.dart';
import 'package:site_historia/Support/routesName_support.dart';
import 'package:velocity_x/velocity_x.dart';

/// Recebe um objeto `Notice`, que exibe sua imagem, título, subtítulo e data de postagem.
class NoticeTileMobile extends StatelessWidget {
  final Notice notice;
  NoticeTileMobile(this.notice);

  @override
  Widget build(BuildContext context) {
    final _onTap = () {
      return VxNavigator.of(context).push(Uri(
          path: RouteNames.NOTICES,
          queryParameters: {"id": notice.id.toString()}));
    };
    final datePost = notice.datePost.split(" ");
    return SingleChildScrollView(
      child: Column(
        children: [
          InkWell(
                onTap: _onTap,
                child: CustomImage(
                  height: 150,
                  image: notice.thumb,
                  fit: BoxFit.contain,
                ),
          ),   InkWell(
                      onTap: _onTap,
                      splashColor: Colors.transparent,
                      child: CustomText(notice.title,
                          style: Theme.of(context).textTheme.headline5)),
                 InkWell(
                      onTap: _onTap,
                      splashColor: Colors.transparent,
                      child: CustomText(
                        notice.subtitle,
                        style: Theme.of(context).textTheme.subtitle1,
                      )),
                 CustomText(
                    "Publicado dia ${datePost[0]} ás ${datePost[1]}",
                    maxLines: 1,
                    padding: EdgeInsets.all(12.0),
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.caption,
                  ),
                
              ],
            ),



    );
  }
}

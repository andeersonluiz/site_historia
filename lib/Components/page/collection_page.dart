/// Widget responsável por exibir a página de acervo.
///
/// {@category Component}
/// {@subCategory Page}
// ignore: library_names
library CollectionPage;

import 'package:flutter/material.dart';
import 'package:site_historia/Components/widget/customText_component.dart';
import 'package:site_historia/Desktop/footer/footer_desktop.dart';
import 'package:site_historia/Components/widget/collectionItem_component.dart';
import 'package:site_historia/Mobile/footer/footer_mobile.dart';
import 'package:site_historia/Model/collection_item.dart';
import 'package:site_historia/Model/collection_model.dart';

/// A tela de recomendações utiliza o objeto `Collection` e o widget `CollectionItemWidget()` para exibir
/// as variáveis do objeto de acordo com o tipo que são: filmes, livros, artigos e outros.

class CollectionPage extends StatelessWidget {
  final Collection collection;
  CollectionPage(this.collection);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(16.0),
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CustomText("Acervo",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline4!),
            ),
            Divider(
              thickness: 1.0,
            ),
            collection.exams.length > 0
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      "Provas",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  )
                : Container(),
            for (CollectionItem collection in collection.exams)
              CollectionItemWidget(
                collection,
                isExam: true,
              ),
            collection.books.length > 0
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      "Livros",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  )
                : Container(),
            for (CollectionItem collection in collection.books)
              CollectionItemWidget(collection),
            collection.articles.length > 0
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      "Artigos",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  )
                : Container(),
            for (CollectionItem collection in collection.articles)
              CollectionItemWidget(collection),
            collection.others.length > 0
                ? Align(
                    alignment: Alignment.centerLeft,
                    child: CustomText(
                      "Outros",
                      textAlign: TextAlign.left,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  )
                : Container(),
            for (CollectionItem collection in collection.others)
              CollectionItemWidget(collection),
          ]),
        ),
        MediaQuery.of(context).size.width > 600
            ? FooterDesktop()
            : FooterMobile(),
      ],
    );
  }
}

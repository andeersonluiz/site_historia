/// Widget responsável pela exibir o menu de pesquisa em `notice_page´.
///
/// {@category Component}
/// {@subCategory Widget}
// ignore: library_names
library SearchBar;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Store/notice_store.dart';

/// Exibe um menu de pesquisa solicitando o texto a ser pesquisado, quando o usuário clica
/// em pesquisar é enviada a informação para o banco de dados através do método `noticeStore.search(String text)`
/// que devolve a lista filtrada de acordo com a busca.
class SearchBar extends StatelessWidget {
  final width;
  SearchBar({required this.width});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final noticeStore = Provider.of<NoticeStore>(context);
    return Container(
      width: width,
      margin: EdgeInsets.all(8.0),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        horizontalTitleGap: 0,
        title: TextField(
          cursorColor: Theme.of(context).primaryColor,
          controller: controller,
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(color: Theme.of(context).primaryColor),
          decoration: InputDecoration(
            labelStyle: Theme.of(context)
                .textTheme
                .caption!
                .copyWith(color: Theme.of(context).primaryColor),
            focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor),),
          hintText: 'Digite para pesquisar...',
            contentPadding: EdgeInsets.only(left: 16, bottom: 28.0),
          ),
        ),
        trailing: IconButton(
          padding: EdgeInsets.only(bottom: 28.0),
          splashRadius: 25.0,
          color: Theme.of(context).primaryColor,
          icon: Icon(Icons.search),
          onPressed: () {
            noticeStore.search(controller.text);
            noticeStore.updateMenuBar("");
          },
        ),
      ),
    );
  }
}

/// Widget responsável por padronizar a exibição de mensagem de erro.
///
/// {@category Component}
/// {@subCategory Widget}
// ignore: library_names
library ErrorMsg;
import 'package:flutter/material.dart';

class ErrorMsg extends StatelessWidget {
  final String text;

  ErrorMsg(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: Theme.of(context).textTheme.caption!.copyWith(color: Colors.red),
      ),
    );
  }
}

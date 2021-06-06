/// Widget responsável por padronizar a exibição do carregamento.
///
/// {@category Component}
/// {@subCategory Widget}
// ignore: library_names
library CustomLoading;

import 'package:flutter/material.dart';

class CustomLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          child: Center(
              child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                      Theme.of(context).backgroundColor),
                  backgroundColor: Theme.of(context).primaryColor))),
    );
  }
}

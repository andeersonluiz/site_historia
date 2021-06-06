/// Widget responsável por exibir o footer para tamanho < 600px.
///
/// {@category Mobile}
/// {@subCategory Footer}
// ignore: library_names
library FooterMini;

import 'package:flutter/material.dart';

import '../../../Components/widget/footerAbout_component.dart';
import '../../../Components/widget/footerIconButton_component.dart';

/// Exibe o Footer da página com informações de contatos e texto sobre o site.
class FooterMini extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Expanded(
        flex: 3,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButtonFooter(Icons.location_on, () {}),
            IconButtonFooter(Icons.phone, () {}),
            IconButtonFooter(Icons.email, () {}),
          ],
        ),
      ),
      Expanded(
        flex: 7,
        child: About(
            iconContactAlign: CrossAxisAlignment.center,
            textAlign: TextAlign.center,
            iconSocialsAlign: MainAxisAlignment.center),
      ),
    ]);
  }
}

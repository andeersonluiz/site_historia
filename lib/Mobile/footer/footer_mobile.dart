/// Widget responsável por exibir o footer (versão mobile).
///
/// {@category Mobile}
/// {@subCategory Footer}
// ignore: library_names
library FooterMobile;

import 'package:flutter/material.dart';
import '../../Components/widget/footerContact_component.dart';
import 'mini/footerMini_mobile.dart';
import '../../Components/widget/footerAbout_component.dart';

/// Exibe o Footer da página com informações de contatos e texto sobre o site.
class FooterMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      height: 200,
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: width > 600
            ? Row(children: [
                FooterContact(),
                Expanded(
                  child: About(
                      iconContactAlign: CrossAxisAlignment.start,
                      textAlign: TextAlign.justify,
                      iconSocialsAlign: MainAxisAlignment.start),
                ),
              ])
            : FooterMini(),
      ),
    );
  }
}

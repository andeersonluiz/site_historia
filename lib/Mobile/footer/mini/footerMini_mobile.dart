/// Widget responsável por exibir o footer para tamanho < 600px.
///
/// {@category Mobile}
/// {@subCategory Footer}
// ignore: library_names
library FooterMini;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
            IconButtonFooter(Icons.location_on, () {
          _launchURL("https://www.google.com/maps/place/CEFET-RJ/@-22.9124772,-43.2269618,17z/data=!3m1!4b1!4m5!3m4!1s0x997e58277f6197:0xbcccee561098f3b6!8m2!3d-22.9124772!4d-43.2247731");
        }),
            !kIsWeb?IconButtonFooter(Icons.phone, () {
              _launchURL('tel:${552125663022}');
            }):IconButtonFooter(Icons.phone,null),
            !kIsWeb?IconButtonFooter(Icons.email, () {
              _launchURL('mailto:monitoriahis.cefetrj@gmail.com');
            }):IconButtonFooter(Icons.email, null),
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

  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

}

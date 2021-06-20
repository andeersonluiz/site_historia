/// Widget responsável por exibir as informações de contato no footer.
///
/// {@category Component}
/// {@subCategory Widget}
// ignore: library_names
library FooterContact;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'footerIconButton_component.dart';

class FooterContact extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButtonFooter(Icons.location_on, () {
                _launchURL("https://www.google.com/maps/place/CEFET-RJ/@-22.9124772,-43.2269618,17z/data=!3m1!4b1!4m5!3m4!1s0x997e58277f6197:0xbcccee561098f3b6!8m2!3d-22.9124772!4d-43.2247731");
              }),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SelectableText('Av. Maracanã, 229 - Maracanã',
                      style: Theme.of(context).textTheme.caption),
                  SelectableText(
                    'Rio de Janeiro - Brasil',
                    style: Theme.of(context).textTheme.caption,
                  )
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              !kIsWeb?IconButtonFooter(Icons.phone, () {
                  _launchURL('tel:${552125663022}');
              }):IconButtonFooter(Icons.phone,null),
              SelectableText(
                '(21) 2566-3022',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              !kIsWeb?IconButtonFooter(Icons.email, () {
                _launchURL('mailto:monitoriahis.cefetrj@gmail.com');
              }):IconButtonFooter(Icons.email, null),
              SelectableText(
                'monitoriahis.cefetrj@gmail.com',
                style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ],
      ),
    );
  }
  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

}

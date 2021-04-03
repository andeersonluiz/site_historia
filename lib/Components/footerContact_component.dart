import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:site_historia/Components/footerIconButton_component.dart';

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
              IconButtonFooter(Icons.location_on, () {}),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Av. Maracanã, 229 - Maracanã',
                      style: Theme.of(context).textTheme.caption),
                  Text(
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
              IconButtonFooter(Icons.phone, () {}),
              Text('Telefone'),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButtonFooter(Icons.email, () {}),
              AutoSizeText(
                'email@gmail.com',
                minFontSize: 5,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

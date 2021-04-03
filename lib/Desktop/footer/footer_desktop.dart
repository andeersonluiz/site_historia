import 'package:flutter/material.dart';
import 'package:site_historia/Components/footerContact_component.dart';
import 'package:site_historia/Components/footerAbout_component.dart';

class FooterDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170,
      color: Theme.of(context).primaryColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          FooterContact(),
          Expanded(
            child: About(
                      iconContactAlign: CrossAxisAlignment.start,
                      textAlign: TextAlign.justify,
                      iconSocialsAlign: MainAxisAlignment.start,
                      sizeContainerText:550,
                      ),
          ),
        ]),
      ),
    );
  }
}

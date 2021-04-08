import 'package:flutter/material.dart';
import 'package:site_historia/Components/footerContact_component.dart';
import 'package:site_historia/Mobile/footer/mini/footerMini_mobile.dart';
import '../../Components/footerAbout_component.dart';

class FooterMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    print(width);
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

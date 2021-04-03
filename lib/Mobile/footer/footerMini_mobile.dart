import 'package:flutter/material.dart';
import 'package:site_historia/Components/footerIconButton_component.dart';
import '../../Components/footerAbout_component.dart';

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

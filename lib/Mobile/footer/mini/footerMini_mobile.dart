import 'package:flutter/material.dart';

import '../../../Components/widget/footerAbout_component.dart';
import '../../../Components/widget/footerIconButton_component.dart';

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

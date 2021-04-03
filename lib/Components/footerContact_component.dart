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
              Text('(21) 9999-9999',style: Theme.of(context).textTheme.caption,),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButtonFooter(Icons.email, () {}),
              Text(
                'email@gmail.com',style: Theme.of(context).textTheme.caption,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

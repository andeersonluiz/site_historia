import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Information extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Center(child: Text("Para mais informações acesse nossos meios de comunicação:",textAlign: TextAlign.center,),
        ),),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.email),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("aaaaaaa@gmail.com"),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(FontAwesomeIcons.facebook),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(FontAwesomeIcons.instagram),
              ),
            ],
          ),
        )
      ],
    );
  }
}

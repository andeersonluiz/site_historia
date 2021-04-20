import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:site_historia/Desktop/appBar/verticalItem_desktop.dart';

class VerticalAppBarMin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Icon(FontAwesomeIcons.bookOpen, size: 30),
            ),
            Divider(height:0,color: Theme.of(context).iconTheme.color,),
            VerticalItem(
                "Projetos","",Icons.precision_manufacturing_outlined,isMini: true,
            ),
            Divider(height:0,color: Theme.of(context).iconTheme.color,),
            VerticalItem(
                "Noticias","",Icons.precision_manufacturing_outlined,isMini: true,
            ),
            Divider(height:0,color: Theme.of(context).iconTheme.color,),
                        VerticalItem(
                "Professores","",Icons.precision_manufacturing_outlined,isMini: true,
            ),
            Divider(height:0,color: Theme.of(context).iconTheme.color,),
                        VerticalItem(
                "Acervo","",Icons.precision_manufacturing_outlined,isMini: true,
            ),

            Divider(height:0,color: Theme.of(context).iconTheme.color,),
          
          ],
        ),
      );
  }
}
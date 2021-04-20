import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Desktop/appBar/verticalItem_desktop.dart';
import 'package:site_historia/firebase/project_firestore.dart';

class VerticalAppBarMax extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    ProjectFirestore projectFirestore = Provider.of<ProjectFirestore>(context);
    return 
         Column(
          children: [
             Container(
                  padding: const EdgeInsets.all(24.0),
                  child: Text("Ola ${projectFirestore.username}!",style: Theme.of(context).textTheme.headline6,),

            ),
            Divider(height:0,color: Theme.of(context).iconTheme.color,),
            VerticalItem(
                "Projetos","",Icons.precision_manufacturing_outlined
            ),
            Divider(height:0,color: Theme.of(context).iconTheme.color,),
            VerticalItem(
                "Noticias","",Icons.precision_manufacturing_outlined
            ),
            Divider(height:0,color: Theme.of(context).iconTheme.color,),
                        VerticalItem(
                "Professores","",Icons.precision_manufacturing_outlined
            ),
            Divider(height:0,color: Theme.of(context).iconTheme.color,),
                        VerticalItem(
                "Acervo","",Icons.precision_manufacturing_outlined
            ),

            Divider(height:0,color: Theme.of(context).iconTheme.color,),

          ],
        
      );
  }
}
import 'package:flutter/material.dart';
import 'package:site_historia/model/project_model.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  ProjectCard(this.project);


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Card(
        elevation: 10,
        clipBehavior:Clip.antiAliasWithSaveLayer,
        semanticContainer: true,
        child: Column( 
          children: [
            Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Spacer(),
            IconButton(icon: Icon(Icons.edit,color: Theme.of(context).primaryColor,),onPressed: (){},),
            IconButton(icon: Icon(Icons.delete,color: Theme.of(context).primaryColor,),onPressed: (){},),
          ],),
          Row(
            children: [
            Expanded(
              flex:3,
              child: Image.asset("test.jpg",fit: BoxFit.fill,height: 250
              )),
              Expanded(
                flex:7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(project.name,maxLines:1,overflow:TextOverflow.ellipsis,style: Theme.of(context).textTheme.headline5!.copyWith(color:Theme.of(context).primaryColor)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(project.content,maxLines:6,overflow:TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyText1!.copyWith(color:Theme.of(context).primaryColor)),
                  ),
                  Row(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text("Autor: "+project.author,maxLines:1,overflow:TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyText1!.copyWith(color:Theme.of(context).primaryColor)),
                                ),
Spacer(),
Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Text("Data do Post: "+project.datePost,maxLines:1,overflow:TextOverflow.ellipsis,style: Theme.of(context).textTheme.bodyText1!.copyWith(color:Theme.of(context).primaryColor)),
)
                  ],)
            ],),
                ),
              ],
          )
          
          ]
        )
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/customLoading_component.dart';
import 'package:site_historia/Desktop/widget/projectCard_desktop.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/firebase/project_firestore.dart';
import 'package:site_historia/model/project_model.dart';

class AdminProjectsPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final projectFirestore = Provider.of<ProjectFirestore>(context);
    return Expanded(
      child: Container(
        child: FutureBuilder(
            future: projectFirestore.getProjects(),
            builder: (ctx, snp) {
              if (snp.hasError) {
                return ErrorLoad(
                  color: Theme.of(context).primaryColor,
                );
              } else if (snp.hasData) {
                List<Project> listProjects = snp.data as List<Project>;
                return ListView(
                  children: [
                    ListTile(
                      leading: Icon(Icons.add_circle_rounded),
                      title: Text("Adicionar Projeto",style: Theme.of(context).textTheme.bodyText1!.copyWith(color:Theme.of(context).primaryColor),),
                      onTap: (){},
                    ),
                    for (var project in listProjects) ProjectCard(project),
                  ],
                );
              } else {
                return CustomLoading();
              }
            }),
      ),
    );
  }
}

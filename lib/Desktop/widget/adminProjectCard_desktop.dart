/// Widget responsável por exibir um card com informações do projeto (Admin - desktop).
///
/// {@category Desktop}
/// {@subCategory Widget}
// ignore: library_names
library AdminProjectCardDesktop;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/widget/customButton_component.dart';
import 'package:site_historia/Components/widget/customImage_component.dart';
import 'package:site_historia/Components/widget/customText_component.dart';
import 'package:site_historia/Store/project_store.dart';
import 'package:site_historia/Support/routesName_support.dart';
import 'package:site_historia/Model/project_model.dart';
import 'package:velocity_x/velocity_x.dart';

/// É feita a montagem do card, onde recebe um objeto `Project` que contém informações como:
/// nome do projeto, data de postagem, autor, imagem, opções de excluir e editar projeto.
/// Quando selecionada a opção de excluir é exibido um pop up confirmando a exclusão e no editar
/// é redirecionado para rota `RouteNames.UPDATE_PROJECT`.
class AdminProjectCardDesktop extends StatelessWidget {
  final Project project;
  final double sizeCard = 250;
  AdminProjectCardDesktop(this.project);

  @override
  Widget build(BuildContext context) {
    final projectStore = Provider.of<ProjectStore>(context);

    return Container(
      padding: EdgeInsets.all(8.0),
      child: Card(
          elevation: 10,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          semanticContainer: true,
          child: Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () => VxNavigator.of(context).push(Uri(
                      path: RouteNames.UPDATE_PROJECT,
                      queryParameters: {"id": project.id.toString()})),
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () =>
                      _showMaterialDialog(context, project, projectStore),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child:CustomImage(
                        height: sizeCard,
                        image:project.imageHeader),),
                Expanded(
                  flex: 7,
                  child: Container(
                    height: sizeCard,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Spacer(),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(project.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                        color: Theme.of(context).primaryColor)),
                          ),
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Autor: " + project.author,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color:
                                              Theme.of(context).primaryColor)),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text("Data do Post: " + project.datePost,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color:
                                              Theme.of(context).primaryColor)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ])),
    );
  }

  _showMaterialDialog(
      BuildContext context, Project project, ProjectStore projectStore) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new CustomText(
                "Confirmar Exclusão",
                style: Theme.of(context).textTheme.headline5,
              ),
              content: new CustomText(
                "Tem certeza que deseja excluir o projeto ${project.name}?",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              actions: <Widget>[
                CustomButton(
                    text: "Sim",
                    onPressed: () async {
                      await projectStore.deleteProject(project.id);
                      projectStore.getProjects();
                      Navigator.of(context).pop();
                    }),
                CustomButton(
                  text: "Não",
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ));
  }
}

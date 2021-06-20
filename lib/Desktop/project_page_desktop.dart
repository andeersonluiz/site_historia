/// Widget responsável por exibir informações de projetos (versão desktop).
///
/// {@category Desktop}
/// {@subCategory Page}
// ignore: library_names
library ProjectPageDesktop;
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:site_historia/Components/widget/author_component.dart';
import 'package:site_historia/Components/widget/customImage_component.dart';
import 'package:site_historia/Components/widget/customText_component.dart';
import 'package:site_historia/Components/widget/htmlViewer_component.dart';
import 'package:site_historia/Desktop/footer/footer_desktop.dart';
import 'package:site_historia/Model/project_model.dart';

/// Widget que recebe um objeto `Project`. Onde são organizadas as informações do projeto.
/// O widget `HtmlViewer(String conteudo)` é usado para generalizar o visualizador de html.
class ProjectPageDesktop extends StatelessWidget {
  final Project project;
  ProjectPageDesktop(this.project);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: CustomImage(
            height: 300,
            width: MediaQuery.of(context).size.width,
            image: project.imageHeader,
            padding: EdgeInsets.zero,
            fit: BoxFit.fill,
          ),
        ),
        Divider(
          height: 0,
          thickness: 1.0,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: SelectableText(project.name,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Theme.of(context).primaryColor)),
          ),
        ),
        Divider(height: 1,thickness: 1.0,),
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 7,
                child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: HtmlViewer(project.content),
                  ),

              ),
              VerticalDivider(thickness: 1,),
              Expanded(
                flex: 3,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: CustomText("Participantes",
                              maxLines: 1,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                      color: Theme.of(context).primaryColor)),
                        ),
                      ),
                      for (var teacher in project.teachers)
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                            child: CustomText(
                              teacher.name + " (Professor)",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2!
                                  .copyWith(
                                      color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                      for (var participant in project.participants)
                        if(participant.name.trim()!="")
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                            child: CustomText(
                              participant.name + " (Aluno)",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      color: Theme.of(context).primaryColor),
                            ),
                          ),
                        ),
                    ]),
              ),
            ],
          ),
        ),
        FooterDesktop(),
      ],
    );
  }
}

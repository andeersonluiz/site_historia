/// Widget responsável por exibir informações de projetos (versão mobile).
///
/// {@category Mobile}
/// {@subCategory Page}
// ignore: library_names
library ProjectPageMobile;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:site_historia/Components/widget/customImage_component.dart';
import 'package:site_historia/Components/widget/htmlViewer_component.dart';
import 'package:site_historia/Mobile/footer/footer_mobile.dart';
import 'package:site_historia/Model/project_model.dart';

/// Widget que recebe um objeto `Project`. Onde são organizadas as informações do projeto.
/// O widget `HtmlViewer(String conteudo)` é usado para generalizar o visualizador de html.
class ProjectPageMobile extends StatelessWidget {
  final Project project;
  ProjectPageMobile(this.project);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
          CustomImage(
            height: 200,
            width: MediaQuery.of(context).size.width,
            image: project.imageHeader,
            padding: EdgeInsets.zero,
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
        Divider(
          height: 0,
          thickness: 1.0,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: HtmlViewer(project.content),
            ),
            Divider(
              thickness: 1.0,
            ),
            Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Center(
                  child: SelectableText("Participantes",
                      maxLines: 1,
                      style: Theme.of(context)
                          .textTheme
                          .headline5!
                          .copyWith(color: Theme.of(context).primaryColor)),
                ),
              ),
              for (var teacher in project.teachers)
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: SelectableText(
                      teacher.name + " (Professor)",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle2!
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
              for (var participant in project.participants)
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Center(
                    child: SelectableText(
                      participant.name + " (Aluno)",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1!
                          .copyWith(color: Theme.of(context).primaryColor),
                    ),
                  ),
                ),
            ]),
          ],
        ),
        FooterMobile(),
      ],
    );
  }
}

import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:site_historia/Components/customImage_component.dart';
import 'package:site_historia/Components/htmlViewer_component.dart';
import 'package:site_historia/Desktop/footer/footer_desktop.dart';
import 'package:site_historia/Model/project_model.dart';

class ProjectPageDesktop extends StatelessWidget {
  final Project project;
  ProjectPageDesktop(this.project);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Stack(children: [
          CustomImage(
            height: 300,
            width: MediaQuery.of(context).size.width,
            image: project.imageHeader,
            padding: EdgeInsets.zero,
          ),
          Container(
            height: 300,
            width: MediaQuery.of(context).size.width,
            color: Colors.white.withOpacity(0.4),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(project.name,
                    style: Theme.of(context)
                        .textTheme
                        .headline3!
                        .copyWith(color: Theme.of(context).primaryColor)),
              ),
            ),
          ),
        ]),
        Divider(height: 1),
        Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 7,
                child: Container(
                  decoration: DottedDecoration(
                      shape: Shape.line, linePosition: LinePosition.right),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: HtmlViewer(project.content),
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Center(
                          child: Text("Participantes",
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
                            child: Text(
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
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                            child: Text(
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
        Divider(
          thickness: 1.0,
        ),
        Row(
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
              child: Text(
                "Autor: ${project.author}",
                style: Theme.of(context).textTheme.caption!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontStyle: FontStyle.italic),
              ),
            ),
            Spacer(),
            Padding(
              padding:
                  const EdgeInsets.only(right: 20.0, left: 20.0, bottom: 20.0),
              child: Text(
                "Data publicação: ${project.datePost}",
                style: Theme.of(context).textTheme.caption!.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
        FooterDesktop(),
      ],
    );
  }
}

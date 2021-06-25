/// Widget responsável por exibir as informações de professores na `about_page`.
///
/// {@category Component}
/// {@subCategory Widget}
// ignore: library_names
library TeacherTile;

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:site_historia/Components/widget/customImage_component.dart';
import 'package:site_historia/Model/project_model.dart';
import 'package:site_historia/Model/teacher_model.dart';
import 'package:site_historia/Support/globals_variables.dart';
import 'package:site_historia/Support/routesName_support.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:velocity_x/velocity_x.dart';

/// Exibe uma imagem circular e informações referente ao professor.
class TeacherTile extends StatelessWidget {
  final Teacher teacher;
  TeacherTile(this.teacher);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 8,
            child: InkWell(
              onTap: (){
                VxNavigator.of(context).push(Uri(path: RouteNames.TEACHERS,queryParameters: {"id":teacher.id.toString()}));
              },
              child: CustomImage(
                height: 150,
                width: MediaQuery.of(context).size.width,
                image: teacher.image==""?GlobalsVariables.srcDefaultImage:teacher.image,
                padding: EdgeInsets.zero,
                fit: BoxFit.cover,
                isOval: true,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SelectableText(
                teacher.name,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: Theme.of(context).primaryColor),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RichText(
                  text: TextSpan(
                      text: teacher.link != "" ? teacher.link : "-",
                      style: teacher.link != ""
                          ? Theme.of(context).textTheme.caption!.copyWith(
                              color: Colors.blueAccent,
                              decorationColor: Colors.blueAccent,
                              decoration: TextDecoration.underline)
                          : Theme.of(context)
                              .textTheme
                              .caption!
                              .copyWith(color: Theme.of(context).primaryColor),
                      recognizer: teacher.link != ""
                          ? (TapGestureRecognizer()
                            ..onTap = () {
                              if (!teacher.link.contains("http://") &&
                                  !teacher.link.contains("https://")) {
                                var linkLauncher = "https://" + teacher.link;
                                _launchURL(linkLauncher);
                              } else {
                                _launchURL(teacher.link);
                              }
                            })
                          : null),
                )),
          ),
          Expanded(
            flex: 2,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: teacher.projects.length > 0
                    ? _buildTextProjects(teacher.projects, context)
                    : _buildText("Projeto(s): -", context)),
          ),
        ],
      ),
    );
  }

  SelectableText _buildText(String string, BuildContext context) {
    return SelectableText(
      string,
      maxLines: 2,
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .subtitle2!
          .copyWith(color: Theme.of(context).primaryColor),
    );
  }

  SelectableText _buildTextProjects(
      List<Project> projects, BuildContext context) {
    List<String> namesProjects = projects.map((e) => e.name).toList();
    return SelectableText(
      "Projeto(s): " + namesProjects.join(", "),
      maxLines: 2,
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .subtitle2!
          .copyWith(color: Theme.of(context).primaryColor),
    );
  }

  void _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
}

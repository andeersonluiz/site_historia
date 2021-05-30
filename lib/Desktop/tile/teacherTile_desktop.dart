import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:site_historia/Components/customImage_component.dart';
import 'package:site_historia/Model/project_model.dart';
import 'package:site_historia/Model/teacher_model.dart';
import 'package:url_launcher/url_launcher.dart';

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
            child: CustomImage(
              height: 150,
              width: MediaQuery.of(context).size.width,
              image: teacher.image,
              padding: EdgeInsets.zero,
              isOval: true,
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AutoSizeText(
                teacher.name,
                maxFontSize: 20,
                minFontSize: 5,
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
                    : _buildText("Projetos: -", context)),
          ),
        ],
      ),
    );
  }

  AutoSizeText _buildText(String string, BuildContext context) {
    return AutoSizeText(
      string,
      maxFontSize: 20,
      minFontSize: 5,
      maxLines: 2,
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .subtitle2!
          .copyWith(color: Theme.of(context).primaryColor),
    );
  }

  AutoSizeText _buildTextProjects(
      List<Project> projects, BuildContext context) {
    List<String> namesProjects = projects.map((e) => e.name).toList();
    return AutoSizeText(
      "Projetos: " + namesProjects.join(", "),
      maxFontSize: 20,
      minFontSize: 13,
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

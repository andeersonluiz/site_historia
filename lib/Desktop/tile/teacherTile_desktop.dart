import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:site_historia/Components/customImage_component.dart';
import 'package:site_historia/Model/teacher_model.dart';

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
              flex: 6,
              child: CustomImage(
                height: 150,
                image: "assets/test.jpg",
                circularRadius: 48.0,
                padding: EdgeInsets.zero,
              )),
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
                child: teacher.projects.length > 0
                    ? _buildText("Projetos: " + teacher.projects, context)
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
      minFontSize: 8,
      maxLines: 2,
      textAlign: TextAlign.center,
      style: Theme.of(context)
          .textTheme
          .subtitle2!
          .copyWith(color: Theme.of(context).primaryColor),
    );
  }
}

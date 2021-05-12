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
                width: MediaQuery.of(context).size.width,
                image:
                    "data:image/jpeg;base64,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",
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

import 'package:flutter/material.dart';
import 'package:site_historia/Mobile/footer/footer_mobile.dart';
import 'package:site_historia/Mobile/widget/customDivider_desktop.dart';
import 'package:site_historia/model/project_model.dart';

class ProjectPageMobile extends StatelessWidget {
  final Project project;
  ProjectPageMobile(this.project);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(1),
                image: DecorationImage(
                  image: NetworkImage(
                    project.imageHeader,
                  ),
                  fit: BoxFit.fill,
                )),
          ),
          Container(
            height: 200,
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
        CustomDivider(),
        IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  project.content,
                  textAlign: TextAlign.justify,
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1!
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
              ),
              CustomDivider(),
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Center(
                    child: Text("Participantes",
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
                      child: Text(
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
                      child: Text(
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
        ),
        FooterMobile(),
      ],
    );
  }
}

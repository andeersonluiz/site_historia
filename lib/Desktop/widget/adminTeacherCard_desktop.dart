import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/customButton_component.dart';
import 'package:site_historia/Components/customImage_component.dart';
import 'package:site_historia/Components/customText_component.dart';
import 'package:site_historia/Model/teacher_model.dart';
import 'package:site_historia/Store/project_store.dart';
import 'package:site_historia/Store/teacher_store.dart';
import 'package:site_historia/Support/RoutesName_support.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminTeacherCardDesktop extends StatelessWidget {
  final Teacher teacher;
  final double sizeCard = 250;
  AdminTeacherCardDesktop(this.teacher);

  @override
  Widget build(BuildContext context) {
    final teacherStore = Provider.of<TeacherStore>(context);
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
                      path: RouteNames.UPDATE_TEACHER,
                      queryParameters: {"id": teacher.id.toString()})),
                ),
                IconButton(
                  icon: Icon(
                    Icons.delete,
                    color: Theme.of(context).primaryColor,
                  ),
                  onPressed: () => _showMaterialDialog(
                      context, teacher, teacherStore, projectStore),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: CustomImage(
                        fit: BoxFit.cover,
                        height: sizeCard,
                        image: teacher.image)),
                Expanded(
                  flex: 7,
                  child: Container(
                    height: sizeCard,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(teacher.name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(
                                    color: Theme.of(context).primaryColor)),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ])),
    );
  }

  _showMaterialDialog(BuildContext context, Teacher teacher,
      TeacherStore teacherStore, ProjectStore projectStore) {
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
              title: new CustomText(
                "Confirmar Exclusão",
                style: Theme.of(context).textTheme.headline5,
              ),
              content: new CustomText(
                "Tem certeza que deseja excluir o projeto ${teacher.name}?",
                style: Theme.of(context).textTheme.subtitle1,
              ),
              actions: <Widget>[
                CustomButton(
                    text: "Sim",
                    onPressed: () async {
                      await teacherStore.deleteTeacher(teacher.id);
                      teacherStore.getTeachers();
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

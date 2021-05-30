import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/widget/customText_component.dart';
import 'package:site_historia/Components/widget/customLoading_component.dart';
import 'package:site_historia/Components/widget/adminTeacherCard_component.dart';
import 'package:site_historia/Model/teacher_model.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Store/teacher_store.dart';
import 'package:site_historia/Support/routesName_support.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminTeacherPageMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final teacherStore = Provider.of<TeacherStore>(context);

    return Container(
      width: MediaQuery.of(context).size.width,
      child: Observer(builder: (ctx) {
        teacherStore.listTeachers ?? teacherStore.getTeachers();
        switch (teacherStore.listTeachers!.status) {
          case FutureStatus.pending:
            return CustomLoading();
          case FutureStatus.rejected:
            return ErrorLoad(
              color: Theme.of(context).primaryColor,
            );
          case FutureStatus.fulfilled:
            List<Teacher> listTeachers =
                teacherStore.listTeachers!.value as List<Teacher>;
            return Column(
              children: [
                Container(
                  margin: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(
                        width: 1.0, color: Theme.of(context).primaryColor),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.add_circle_rounded),
                    title: CustomText("Adicionar Professor",
                        style: Theme.of(context).textTheme.bodyText1),
                    onTap: () => VxNavigator.of(context)
                        .push(Uri.parse(RouteNames.ADD_TEACHER)),
                  ),
                ),
                for (var teacher in listTeachers)
                  AdminTeacherCard(teacher),
              ],
            );
        }
      }),
    );
  }
}

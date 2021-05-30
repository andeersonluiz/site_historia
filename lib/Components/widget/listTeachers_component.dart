import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/widget/customLoading_component.dart';
import 'package:site_historia/Components/widget/teacherTile_component.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Store/teacher_store.dart';
import 'package:site_historia/Model/teacher_model.dart';

class ListTeachers extends StatelessWidget {
  final sizeImage = 350.0;

  @override
  Widget build(BuildContext context) {
    final _crossAxisSpacing = 10.0;
    final _screenWidth = MediaQuery.of(context).size.width;

    TeacherStore teacherStore = Provider.of<TeacherStore>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Professores",
            style: Theme.of(context)
                .textTheme
                .headline5!
                .copyWith(color: Theme.of(context).primaryColor),
          ),
        ),
        Observer(builder: (ctx) {
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
              final crossAxisCount =
                  (MediaQuery.of(context).size.width ~/ sizeImage) >
                          listTeachers.length
                      ? 5
                      : (MediaQuery.of(context).size.width ~/ sizeImage) <= 0
                          ? 1
                          : (MediaQuery.of(context).size.width ~/ sizeImage);
              return SingleChildScrollView(
                child: GridView.count(
                    physics: ScrollPhysics(),
                    primary: true,
                    shrinkWrap: true,
                    crossAxisCount: crossAxisCount,
                    childAspectRatio: (((_screenWidth -
                                ((crossAxisCount - 1) * _crossAxisSpacing)) /
                            crossAxisCount) /
                        sizeImage),
                    mainAxisSpacing: 20.0,
                    crossAxisSpacing: _crossAxisSpacing,
                    padding: EdgeInsets.all(8.0),
                    children: listTeachers
                        .map((item) => Container(
                              height: sizeImage,
                              width: sizeImage,
                              child: TeacherTile(
                                item,
                              ),
                            ))
                        .toList()),
              );
          }
        })
      ],
    );
  }
}

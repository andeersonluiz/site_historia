import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Desktop/tile/teacherTile_desktop.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/firebase/teacher_firestore.dart';
import 'package:site_historia/model/teacher_model.dart';

class ListTeachers extends StatelessWidget {
  final sizeImage = 150.0;
  @override
  Widget build(BuildContext context) {
    TeacherFirestore teacherFirestore = Provider.of<TeacherFirestore>(context);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Professores",
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Theme.of(context).primaryColor),
        ),
        FutureBuilder(
            future: teacherFirestore.getTeachers(),
            builder: (ctx, snp) {
              if (snp.hasError) {
                return ErrorLoad();
              } else if (snp.hasData) {
                List<Teacher> listTeachers = snp.data as List<Teacher>;
                return Center(
                  child: GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: (MediaQuery.of(context).size.width ~/
                                  sizeImage) >
                              listTeachers.length
                          ? listTeachers.length
                          : (MediaQuery.of(context).size.width ~/ sizeImage),
                      mainAxisSpacing: 20.0,
                      crossAxisSpacing: 10.0,
                      padding: EdgeInsets.all(8.0),
                      children: listTeachers
                          .map((item) => Container(
                                height: sizeImage,
                                width: sizeImage,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Theme.of(context).primaryColor),
                                ),
                                child: TeacherTile(item),
                              ))
                          .toList()),
                );
              } else {
                return Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(
                      backgroundColor: Theme.of(context).primaryColor),
                ));
              }
            })
      ],
    );
  }
}

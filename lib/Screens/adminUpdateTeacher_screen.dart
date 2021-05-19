import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Components/customLoading_component.dart';
import 'package:site_historia/Desktop/adminUpdateTeacher_page_desktop.dart';
import 'package:site_historia/Desktop/appBar/verticalAppBar_desktop.dart';
import 'package:site_historia/Mobile/drawer/adminNavigation_drawer_component.dart';
import 'package:site_historia/Model/teacher_model.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Screens/loading_screen.dart';
import 'package:site_historia/Store/teacher_store.dart';
import 'package:site_historia/Support/RoutesName_support.dart';

class AdminUpdateTeacherScreen extends StatefulWidget {
  final String idTeacher;

  AdminUpdateTeacherScreen(this.idTeacher);

  @override
  _AdminUpdateTeacherScreenState createState() =>
      _AdminUpdateTeacherScreenState();
}

class _AdminUpdateTeacherScreenState extends State<AdminUpdateTeacherScreen> {
  @override
  Widget build(BuildContext context) {
    final teacherStore = Provider.of<TeacherStore>(context);
    return ResponsiveBuilder(
      builder: (ctx, sizingInformation) => Scaffold(
          drawer: sizingInformation.isDesktop ? null : AdminNavigatorDrawer(),
          appBar: sizingInformation.isDesktop
              ? null
              : AppBar(
                  centerTitle: true,
                  title: Text("Editar Professor"),
                ),
          body: Observer(builder: (_) {
            teacherStore.listTeachers ?? teacherStore.getTeachers();
            switch (teacherStore.listTeachers!.status) {
              case FutureStatus.pending:
                return Loading();
              case FutureStatus.rejected:
                return ErrorLoad(color: Theme.of(context).primaryColor);
              case FutureStatus.fulfilled:
                return FutureBuilder(
                  future: loadData(),
                  builder: (ctx, snp) {
                    if (snp.hasData) {
                      Teacher teacher = snp.data as Teacher;

                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: ScreenTypeLayout(
                            mobile: AdminUpdateTeacherPageDesktop(teacher),
                            desktop: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    VerticalAppBar(),
                                    Expanded(
                                        child: AdminUpdateTeacherPageDesktop(
                                            teacher)),
                                  ]),
                            )),
                      );
                    } else if (snp.hasError) {
                      return Loading(
                        redirect: true,
                        to: RouteNames.ADMIN_PROJECTS,
                      );
                    } else {
                      return CustomLoading();
                    }
                  },
                );
            }
          })),
    );
  }

  loadData() async {
    final teacherStore = Provider.of<TeacherStore>(context);
    return await teacherStore.getTeacherById(widget.idTeacher);
  }
}

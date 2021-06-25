/// Tela responsável por exibir as informações de professores da coordenação.
///
/// {@category Screen}
// ignore: library_names
library TeacherScreen;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Components/page/teacherInfo_page.dart';
import 'package:site_historia/Components/widget/customLoading_component.dart';
import 'package:site_historia/Desktop/appBar/custtomAppBar_desktop.dart';
import 'package:site_historia/Model/teacher_model.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Screens/loading_screen.dart';
import 'package:site_historia/Store/teacher_store.dart';
import 'package:site_historia/Support/IconsData_support.dart';
import 'package:site_historia/Support/routesName_support.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../Mobile/drawer/navigation_drawer_component.dart';

/// O Widget redireciona para duas telas diferentes, o desktop conta com o `CustomAppBarDesktop` e a mobile
/// possui `NavigationDrawer`. O método `getTeachers()` é chamado para
/// carregar as informações de projetos do banco de dados.
class TeacherScreen extends StatefulWidget {
  final String idTeacher;
  TeacherScreen(this.idTeacher);
  @override
  _TeacherScreenState createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {
  @override
  Widget build(BuildContext context) {
    final teacherStore = Provider.of<TeacherStore>(context);

    return ResponsiveBuilder(
      builder: (ctx, sizingInformation) => Scaffold(
        endDrawer: sizingInformation.isDesktop ? null : NavigationDrawer(),
        appBar: sizingInformation.isDesktop
            ? null
            : AppBar(automaticallyImplyLeading: false, actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Icon(IconsData.LOGO_ICON, size: 30),
          ),
          Spacer(),
          Builder(
            builder: (ctx) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  icon: Icon(
                    Icons.menu,
                  ),
                  onPressed: () => Scaffold.of(ctx).openEndDrawer()),
            ),
          ),
        ]),
        body: Observer(builder: (_) {
          teacherStore.listTeachers ?? teacherStore.getTeachers();
          switch (teacherStore.listTeachers!.status) {
            case FutureStatus.pending:
              return Loading();
            case FutureStatus.rejected:
              return ErrorLoad(
                color: Theme.of(context).primaryColor,
              );
            case FutureStatus.fulfilled:
              return FutureBuilder(
                  future: loadData(),
                  builder: (ctx, snp) {
                    if (snp.hasData) {
                      Teacher teacher = snp.data as Teacher;
                      if(!teacher.isCoord){
                        return Loading(
                          redirect: true,
                          to: RouteNames.HOME,
                        );
                      }
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Title(
                          title: "Professores - "+teacher.name,
                          color: Colors.black,
                          child: ScreenTypeLayout(
                              mobile: TeacherInfoPage(teacher),
                              desktop: StickyHeader(
                                  header: CustomAppBarDesktop(),
                                  content: TeacherInfoPage(teacher))),
                        ),
                      );
                    } else if (snp.hasError) {
                      return Loading(
                        redirect: true,
                        to: RouteNames.HOME,
                      );
                    } else {
                      return CustomLoading();
                    }
                  });
          }
        }),
      ),
    );
  }

  loadData() async {
    final teacherStore = Provider.of<TeacherStore>(context);
    return await teacherStore.getTeacherById(widget.idTeacher);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/CustomText_component.dart';
import 'package:site_historia/Components/widget/customButton_component.dart';
import 'package:site_historia/Components/widget/customLoading_component.dart';
import 'package:site_historia/Components/widget/customTextFormField_component.dart';
import 'package:site_historia/Components/widget/customToast_component.dart';
import 'package:site_historia/Components/widget/erroMsg_component.dart';
import 'package:site_historia/Components/widget/image_component.dart';
import 'package:site_historia/Components/widget/project_component.dart';
import 'package:site_historia/Model/project_model.dart';
import 'package:site_historia/Model/teacher_model.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Store/project_store.dart';
import 'package:site_historia/Store/support_store.dart';
import 'package:site_historia/Store/teacher_store.dart';
import 'package:site_historia/Support/routesName_support.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:site_historia/Support/globals_variables.dart';

class AdminUpdateTeacherPage extends StatefulWidget {
  final Teacher teacher;
  AdminUpdateTeacherPage(this.teacher);
  @override
  _AdminUpdateTeacherPageState createState() =>
      _AdminUpdateTeacherPageState();
}

class _AdminUpdateTeacherPageState
    extends State<AdminUpdateTeacherPage> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final supportStore = Provider.of<SupportStore>(context);
    /*CODE PBP*/
    supportStore.clearData();
    supportStore.loadInitialDataTeacher(widget.teacher);
  }

  @override
  Widget build(BuildContext context) {
    final supportStore = Provider.of<SupportStore>(context);
    final teacherStore = Provider.of<TeacherStore>(context);
    final projectStore = Provider.of<ProjectStore>(context);

    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Observer(
          builder: (_) {
            projectStore.listProjects ?? projectStore.getProjects();
            switch (projectStore.listProjects!.status) {
              case FutureStatus.pending:
                return CustomLoading();
              case FutureStatus.rejected:
                return ErrorLoad(
                  color: Theme.of(context).primaryColor,
                );
              case FutureStatus.fulfilled:
                List<Project> listProjects =
                    projectStore.listProjects!.value as List<Project>;
                supportStore.createProjectLocal(listProjects, widget.teacher);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomTextFormField(
                      hintText: "Insira o nome do Professor",
                      labelText: "Nome",
                      maxCharacters: GlobalsVariables.maxCharactersTitle,
                      initialValue: supportStore.title,
                      onChanged: (text) {
                        supportStore.updateTitle(text);
                      },
                      textInputType: TextInputType.name,
                    ),
                    Observer(builder: (_) {
                      return supportStore.msgErrorTitle == ""
                          ? Container()
                          : ErrorMsg(supportStore.msgErrorTitle);
                    }),
                    CustomTextFormField(
                      hintText:
                          "Insira o link de informações sobre professor (opcional)",
                      labelText: "Link",
                      initialValue: supportStore.link,
                      onChanged: (text) {
                        supportStore.updateLink(text);
                      },
                      maxCharacters: GlobalsVariables.maxCharactersSubTitle,
                      textInputType: TextInputType.url,
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomText("Foto professor",
                            style: Theme.of(context).textTheme.headline6)),
                    Observer(
                      builder: (ctx) => ImageWidget(
                        image: supportStore.pathImage,
                      ),
                    ),
                    Observer(builder: (_) {
                      return supportStore.msgErrorImage == ""
                          ? Container()
                          : ErrorMsg(supportStore.msgErrorImage);
                    }),
                    Center(
                        child: CustomText(
                            "Selecione os projetos que o professor participa",
                            style: Theme.of(context).textTheme.subtitle1)),
                    Observer(builder: (_) {
                      projectStore.listProjects ?? projectStore.getProjects();
                      switch (projectStore.listProjects!.status) {
                        case FutureStatus.pending:
                          return CustomLoading();
                        case FutureStatus.rejected:
                          return ErrorLoad(
                              color: Theme.of(context).primaryColor);
                        case FutureStatus.fulfilled:
                          List<Project> projs =
                              projectStore.listProjects!.value as List<Project>;
                          supportStore.createProjectLocal(projs, null);
                          return ProjectWidget(
                              MediaQuery.of(context).size.width > 500 ? 2 : 1);
                      }
                    }),
                    Observer(builder: (_) {
                      return supportStore.msgErrorProject == ""
                          ? Container()
                          : ErrorMsg(supportStore.msgErrorProject);
                    }),
                    Observer(
                      builder: (_) => CustomButton(
                        text: "Atualizar professor",
                        loadingText: "Atualizando professor...",
                        isLoading: supportStore.isLoading!,
                        onPressed: () async {
                          if (supportStore.validateTeacher()) {
                            supportStore.setLoading(true);
                            var result = await teacherStore.updateTeacher(
                              widget.teacher,
                              supportStore.title,
                              supportStore.pathImage!,
                              supportStore.getProjects(),
                              supportStore.link,
                            );
                            supportStore.setLoading(false);
                            if (result) {
                              CustomToast.showToast(
                                  "Professor atualizado com sucesso!!",
                                  Colors.green);
                              projectStore.getProjects();
                              teacherStore.getTeachers();
                              VxNavigator.of(context)
                                  .push(Uri.parse(RouteNames.ADMIN_TEACHERS));
                            } else {
                              CustomToast.showToast(
                                "Não foi possivel atualizar o professor, tente novamente mais tarde.",
                                Colors.red,
                              );
                            }
                          }
                        },
                      ),
                    ),
                  ],
                );
            }
          },
        ),
      ),
    );
  }
}

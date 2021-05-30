import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/widget/customText_component.dart';
import 'package:site_historia/Components/widget/customButton_component.dart';
import 'package:site_historia/Components/widget/customHtmlEditor_component.dart';
import 'package:site_historia/Components/widget/customTextFormField_component.dart';
import 'package:site_historia/Components/widget/customLoading_component.dart';
import 'package:site_historia/Components/widget/customToast_component.dart';
import 'package:site_historia/Components/widget/erroMsg_component.dart';
import 'package:site_historia/Components/widget/image_component.dart';
import 'package:site_historia/Desktop/widget/participant_desktop.dart';
import 'package:site_historia/Desktop/widget/teacher_desktop.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Store/project_store.dart';
import 'package:site_historia/Store/support_store.dart';
import 'package:site_historia/Support/routesName_support.dart';
import 'package:site_historia/Support/globals_variables.dart';
import 'package:site_historia/Model/project_model.dart';
import 'package:site_historia/Model/teacher_model.dart';
import 'package:site_historia/Store/teacher_store.dart';
import 'package:velocity_x/velocity_x.dart';
// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

class AdminUpdateProjectPageDesktop extends StatefulWidget {
  final Project project;
  AdminUpdateProjectPageDesktop(this.project);

  @override
  _AdminUpdateProjectPageDesktopState createState() =>
      _AdminUpdateProjectPageDesktopState();
}

class _AdminUpdateProjectPageDesktopState
    extends State<AdminUpdateProjectPageDesktop> {
  final DateTime timeOpen = DateTime.now();
  bool updated = false;
  ProjectStore? projectStore;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final supportStore = Provider.of<SupportStore>(context);
    projectStore = Provider.of<ProjectStore>(context);
    /*CODE PBP*/
    supportStore.clearData();
    supportStore.loadInitialDataProject(widget.project);

    html.window.onBeforeUnload.listen((event) async {
      /*Listen reload (not delete image when reload)*/
    });
  }

  @override
  Widget build(BuildContext context) {
    final projectStore = Provider.of<ProjectStore>(context);
    final supportStore = Provider.of<SupportStore>(context);
    final teacherStore = Provider.of<TeacherStore>(context);
    final HtmlEditorController contentController = HtmlEditorController();
    return SingleChildScrollView(child: Observer(
      builder: (ctx) {
        teacherStore.listTeachers ?? teacherStore.getTeachers();
        switch (teacherStore.listTeachers!.status) {
          case FutureStatus.pending:
            return CustomLoading();
          case FutureStatus.fulfilled:
            List<Teacher> listTeachers =
                teacherStore.listTeachers!.value as List<Teacher>;
            supportStore.createTeacherLocal(listTeachers, widget.project);
            return Container(
              width: 500,
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CustomTextFormField(
                    hintText: "Insira o titulo",
                    labelText: "Titulo",
                    initialValue: supportStore.title,
                    onChanged: (text) {
                      supportStore.updateTitle(text);
                    },
                    maxCharacters: GlobalsVariables.maxCharactersTitle,
                    textInputType: TextInputType.name,
                  ),
                  Observer(builder: (_) {
                    return supportStore.msgErrorTitle == ""
                        ? Container()
                        : ErrorMsg(supportStore.msgErrorTitle);
                  }),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText("Imagem titulo",
                          style: Theme.of(context).textTheme.headline6)),
                  Observer(
                    builder: (ctx) => ImageWidget(
                      image: supportStore.pathImage,
                      isProject: true,
                      titleProject: supportStore.title,
                    ),
                  ),
                  Observer(builder: (_) {
                    return supportStore.msgErrorImage == ""
                        ? Container()
                        : ErrorMsg(supportStore.msgErrorImage);
                  }),
                  CustomHtmlEditor(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    controller: contentController,
                    onChange: (text) => supportStore.updateContent(projectStore,
                        text, contentController, widget.project.id.toString()),
                    onBeforeCommand: supportStore.updateAfterContent,
                    mediaUploadInterceptor: (file, type) async {
                      var url = await projectStore.convertBase64ToUrl(
                          file.name!,
                          file.bytes!,
                          widget.project.id.toString());
                      contentController.insertNetworkImage(url,
                          filename: file.name!);
                      return false;
                    },
                    initialText: supportStore.htmlContent,
                  ),
                  Observer(builder: (_) {
                    return supportStore.msgErrorContent == ""
                        ? Container()
                        : ErrorMsg(supportStore.msgErrorContent);
                  }),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(children: [
                          Center(
                              child: CustomText(
                                  "Selecione os professores que participam do projeto",
                                  style:
                                      Theme.of(context).textTheme.subtitle1)),
                          Observer(builder: (_) {
                            return supportStore.msgErrorTeacher == ""
                                ? Container()
                                : ErrorMsg(supportStore.msgErrorTeacher);
                          }),
                        ]),
                      ),
                      Expanded(
                        child: Column(children: [
                          Center(
                              child: CustomText(
                                  "Escreva os alunos que participam do projeto",
                                  style:
                                      Theme.of(context).textTheme.subtitle1)),
                          Observer(builder: (_) {
                            return supportStore.msgErrorParticipants == ""
                                ? Container()
                                : ErrorMsg(supportStore.msgErrorParticipants);
                          }),
                        ]),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TeacherWidgetDesktop(),
                      ),
                      Expanded(
                        child: ParticipantWidgetDesktop(),
                      )
                    ],
                  ),
                  CustomButton(
                    text: "Salvar Alterações",
                    loadingText: "Salvango...",
                    isLoading: supportStore.isLoading!,
                    onPressed: () async {
                      if (supportStore.validateProjectDesktop()) {
                        supportStore.setLoading(true);
                        var result = await projectStore.updateProject(
                            widget.project.id,
                            supportStore.title,
                            supportStore.pathImage,
                            supportStore.htmlContent,
                            supportStore.getTeachers(),
                            supportStore.getParticipantsLocalFilled(),
                            GlobalsVariables.username);
                        supportStore.setLoading(false);
                        if (result) {
                          updated = true;
                          CustomToast.showToast(
                              "Projeto alterado com sucesso!!", Colors.green);
                          VxNavigator.of(context)
                              .push(Uri.parse(RouteNames.ADMIN_PROJECTS));
                        } else {
                          CustomToast.showToast(
                            "Não foi possivel alterado seu projeto, tente novamente mais tarde.",
                            Colors.red,
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
            );
          case FutureStatus.rejected:
            return ErrorLoad(
              color: Theme.of(context).primaryColor,
            );
        }
      },
    ));
  }

  @override
  void dispose() {
    if (!updated) {
      projectStore!.clearContent(widget.project.id.toString(), time: timeOpen);
    }
    super.dispose();
  }
}

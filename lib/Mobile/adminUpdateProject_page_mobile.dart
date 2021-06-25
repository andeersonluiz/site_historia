/// Widget responsável por exibir a primeira parte da atualização de projeto (Admin - versão mobile).
///
/// {@category Mobile}
/// {@subCategory Page}
// ignore: library_names
library AdminUpdateProjectPageMobile;

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/widget/customText_component.dart';
import 'package:site_historia/Components/widget/customButton_component.dart';
import 'package:site_historia/Components/widget/customCheckBox_component.dart';
import 'package:site_historia/Components/widget/customHtmlEditor_component.dart';
import 'package:site_historia/Components/widget/customTextFormField_component.dart';
import 'package:site_historia/Components/widget/customLoading_component.dart';
import 'package:site_historia/Components/widget/erroMsg_component.dart';
import 'package:site_historia/Components/widget/image_component.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Store/project_store.dart';
import 'package:site_historia/Store/support_store.dart';
import 'package:site_historia/Model/project_model.dart';
import 'package:site_historia/Model/teacher_model.dart';
import 'package:site_historia/Store/teacher_store.dart';
import 'package:site_historia/Support/globals_variables.dart';
import 'adminUpdateProjectParticipant_page_mobile.dart';

/// Widget que recebe um objeto `Project`. Onde são organizadas as informações para atualização
/// do projeto. É composto pelos widgets `CustomHtmlEditor()` que generaliza o widget de edição de texto,
///  `ImageWidget()` que generaliza a exibição e seleção da imagem do projeto e o
///  `AdminUpdateProjectParticipantPageMobile(int id)` onde o usuário é redirecionado para segunda parte
///  do formulário.
class AdminUpdateProjectPageMobile extends StatefulWidget {
  final Project project;
  AdminUpdateProjectPageMobile(this.project);

  @override
  _AdminUpdateProjectPageMobileState createState() =>
      _AdminUpdateProjectPageMobileState();
}

class _AdminUpdateProjectPageMobileState
    extends State<AdminUpdateProjectPageMobile> {
  SupportStore? supportStore;
  ProjectStore? projectStore;
  final DateTime timeOpen = DateTime.now();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final teacherStore = Provider.of<TeacherStore>(context);
    supportStore = Provider.of<SupportStore>(context);
    projectStore = Provider.of<ProjectStore>(context);

    /*CODE PBP*/
    supportStore!.clearData();
    teacherStore.getTeachers();
    supportStore!.loadInitialDataProject(widget.project);
  }

  @override
  Widget build(BuildContext context) {
    final supportStore = Provider.of<SupportStore>(context);
    final teacherStore = Provider.of<TeacherStore>(context);
    final HtmlEditorController contentController = HtmlEditorController();
    final projectStore = Provider.of<ProjectStore>(context);

    return Observer(
      builder: (ctx) {
        teacherStore.listTeachers ?? teacherStore.getTeachers();
        switch (teacherStore.listTeachers!.status) {
          case FutureStatus.fulfilled:
            List<Teacher> listTeachers =
                teacherStore.listTeachers!.value as List<Teacher>;
            supportStore.createTeacherLocal(listTeachers, widget.project);
            return Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextFormField(
                    hintText: "Insira o título",
                    labelText: "Título",
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
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CustomText("Imagem título (Resolução recomendado:3000x600)",
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
                    initialText: supportStore.htmlContent,
                    mediaUploadInterceptor: (file, type) async {
                      var url = await projectStore.convertBase64ToUrl(
                          file.name,
                          file.bytes!,
                          widget.project.id.toString());
                      contentController.insertNetworkImage(url,
                          filename: file.name);
                      return false;
                    },
                  ),
                  Observer(builder: (_) {
                    return supportStore.msgErrorContent == ""
                        ? Container()
                        : ErrorMsg(supportStore.msgErrorContent);
                  }),
                  Center(
                    child: CustomText(
                        "Selecione os professores que participam do projeto",
                        style: Theme.of(context).textTheme.subtitle1),
                  ),
                  Observer(builder: (_) {
                    return supportStore.msgErrorTeacher == ""
                        ? Container()
                        : ErrorMsg(supportStore.msgErrorTeacher);
                  }),
                  Observer(
                      builder: (context) => ListView.builder(
                          itemCount: supportStore.teacherLocal.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (ctx, index) {
                            return CustomCheckBox(
                                title: supportStore.teacherLocal[index].name,
                                value: supportStore.teacherLocal[index].checked,
                                onChanged: (_) {
                                  supportStore.updateTeacherLocal(
                                      supportStore.teacherLocal[index], index);
                                });
                          })),
                  SizedBox(
                    height: 40,
                  ),
                  CustomButton(
                      text: "Próximo",
                      onPressed: () async {
                        if (supportStore.validateProjectMobileTab1()) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) =>
                                  AdminUpdateProjectParticipantPageMobile(
                                      widget.project.id)));
                        }
                      }),
                ],
              ),
            );
          case FutureStatus.rejected:
            return ErrorLoad(
              color: Theme.of(context).primaryColor,
            );
          case FutureStatus.pending:
            return CustomLoading();
        }
      },
    );
  }

  @override
  void dispose() {
    if (!supportStore!.updated) {
      projectStore!.clearContent(widget.project.id.toString(), time: timeOpen);
    }
    super.dispose();
  }
}

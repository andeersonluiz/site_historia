import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/CustomText_component.dart';
import 'package:site_historia/Components/customButton_component.dart';
import 'package:site_historia/Components/customCheckBox_component.dart';
import 'package:site_historia/Components/customHtmlEditor_component.dart';
import 'package:site_historia/Components/customTextFormField_component.dart';
import 'package:site_historia/Components/customLoading_component.dart';
import 'package:site_historia/Components/customToast_component.dart';
import 'package:site_historia/Components/erroMsg_component.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Store/project_store.dart';
import 'package:site_historia/Store/support_store.dart';
import 'package:site_historia/Support/RoutesName_support.dart';
import 'package:site_historia/Support/globals_variables.dart';
import 'package:site_historia/Model/teacher_model.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:site_historia/Store/teacher_store.dart';

class AdminAddProjectPageDesktop extends StatefulWidget {
  @override
  _AdminAddProjectPageDesktopState createState() =>
      _AdminAddProjectPageDesktopState();
}

class _AdminAddProjectPageDesktopState
    extends State<AdminAddProjectPageDesktop> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final teacherStore = Provider.of<TeacherStore>(context);
    final supportStore = Provider.of<SupportStore>(context);
/*CODE PBP*/
    supportStore.clearData();
    teacherStore.getTeachers();
  }

  @override
  Widget build(BuildContext context) {
    final projectStore = Provider.of<ProjectStore>(context);
    final supportStore = Provider.of<SupportStore>(context);
    final teacherStore = Provider.of<TeacherStore>(context);
    final _picker = ImagePicker();
    final HtmlEditorController contentController = HtmlEditorController();
    final TextEditingController controllerParticipants =
        TextEditingController();
    return SingleChildScrollView(
      child: Observer(
        builder: (ctx) {
          teacherStore.listTeachers ?? teacherStore.getTeachers();

          switch (teacherStore.listTeachers!.status) {
            case FutureStatus.pending:
              return CustomLoading();
            case FutureStatus.fulfilled:
              List<Teacher> listTeachers =
                  teacherStore.listTeachers!.value as List<Teacher>;
              supportStore.createTeacherLocal(listTeachers, null);
              return Container(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    CustomTextFormField(
                      hintText: "Insira o titulo",
                      labelText: "Titulo",
                      maxCharacters: 30,
                      initialValue: supportStore.title,
                      onChanged: (text) {
                        supportStore.updateTitle(text);
                      },
                      textInputAction: TextInputAction.next,
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
                      builder: (ctx) => Container(
                        decoration: supportStore.pathImage!.path != ""
                            ? BoxDecoration(
                                image: DecorationImage(
                                image:
                                    NetworkImage(supportStore.pathImage!.path),
                                fit: BoxFit.fill,
                              ))
                            : BoxDecoration(color: Colors.grey),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              supportStore.pathImage!.path != ""
                                  ? Expanded(
                                      flex: 95,
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            supportStore.title,
                                            style: Theme.of(context)
                                                .textTheme
                                                .headline3!,
                                          ),
                                        ),
                                      ),
                                    )
                                  : Expanded(flex: 85, child: Container()),
                              Spacer(),
                              Expanded(
                                flex: 5,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: InkWell(
                                      child: Icon(Icons.folder),
                                      onTap: () async {
                                        PickedFile? image;
                                        if (!kIsWeb) {
                                          image = await _picker.getImage(
                                              source: ImageSource.gallery);
                                        } else {
                                          image = await _picker.getImage(
                                              source: ImageSource.camera);
                                        }

                                        supportStore.updatePath(image);
                                      }),
                                ),
                              ),
                            ]),
                        height: supportStore.pathImage!.path == "" ? 40 : 300,
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
                      onChange: supportStore.updateContent,
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
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Observer(
                                builder: (context) => ListView.builder(
                                    itemCount: supportStore.teacherLocal.length,
                                    shrinkWrap: true,
                                    itemBuilder: (ctx, index) {
                                      return CustomCheckBox(
                                          title: supportStore
                                              .teacherLocal[index].name,
                                          value: supportStore
                                              .teacherLocal[index].checked,
                                          onChanged: (_) {
                                            supportStore.updateTeacherLocal(
                                                supportStore
                                                    .teacherLocal[index],
                                                index);
                                          });
                                    })),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 5,
                                      child: CustomTextFormField(
                                        controller: controllerParticipants,
                                        textInputType: TextInputType.number,
                                        hintText:
                                            "Digite o numero de participantes (Max. 10)",
                                        labelText: "Numero de participantes",
                                        textInputAction: TextInputAction.next,
                                      ),
                                    ),
                                    Expanded(
                                      flex: 5,
                                      child: CustomButton(
                                        text: "Gerar participantes",
                                        onPressed: () =>
                                            supportStore.validateParticipant(
                                                controllerParticipants.text),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Observer(builder: (_) {
                                return supportStore.msgErrorParticipantsSize ==
                                        ""
                                    ? Container()
                                    : ErrorMsg(
                                        supportStore.msgErrorParticipantsSize);
                              }),
                              Observer(
                                builder: (context) => ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      supportStore.participantsLocal.length,
                                  itemBuilder: (ctx, index) {
                                    return CustomTextFormField(
                                      textInputType: TextInputType.name,
                                      onChanged: (value) => supportStore
                                          .updateParticipants(value, index),
                                      hintText:
                                          "Nome Participante ${index + 1}",
                                      labelText: 'Participante  ${index + 1}',
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    CustomButton(
                      text: "Criar Projeto",
                      onPressed: () async {
                        if (supportStore.validateProjectDesktop()) {
                          var result = await projectStore.addProject(
                              supportStore.title,
                              supportStore.pathImage,
                              supportStore.htmlContent,
                              supportStore.getTeachers(),
                              supportStore.getParticipantsLocalFilled(),
                              GlobalsVariables.username);
                          if (result) {
                            CustomToast.showToast(
                                "Projeto cadastro com sucesso!!", Colors.green);
                            VxNavigator.of(context)
                                .push(Uri.parse(RouteNames.ADMIN_PROJECTS));
                          } else {
                            CustomToast.showToast(
                              "Não foi possivel cadastrar seu projeto, tente novamente mais tarde.",
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
      ),
    );
  }
}

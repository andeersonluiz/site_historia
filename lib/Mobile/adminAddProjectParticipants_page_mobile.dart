import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/CustomText_component.dart';
import 'package:site_historia/Components/customButton_component.dart';
import 'package:site_historia/Components/customTextFormField_component.dart';
import 'package:site_historia/Components/customToast_component.dart';
import 'package:site_historia/Components/erroMsg_component.dart';
import 'package:site_historia/Store/project_store.dart';
import 'package:site_historia/Store/support_store.dart';
import 'package:site_historia/Support/RoutesName_support.dart';
import 'package:site_historia/Support/globals_variables.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminAddProjectParticipantPageMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final projectStore = Provider.of<ProjectStore>(context);

    final supportStore = Provider.of<SupportStore>(context);
    final TextEditingController controllerParticipants =
        TextEditingController();

    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: CustomText("Escreva os alunos que participam do projeto",
                    style: Theme.of(context).textTheme.subtitle1),
              ),
              Observer(builder: (_) {
                return supportStore.msgErrorParticipants == ""
                    ? Container()
                    : ErrorMsg(supportStore.msgErrorParticipants);
              }),
              CustomTextFormField(
                controller: controllerParticipants,
                textInputType: TextInputType.number,
                hintText: "Digite o numero de participantes (Max. 10)",
                labelText: "Numero de participantes",
              ),
              CustomButton(
                  paddingButton: EdgeInsets.all(8.0),
                  expandButton: true,
                  text: "Gerar participantes",
                  onPressed: () {
                    supportStore
                        .validateParticipant(controllerParticipants.text);
                    FocusScope.of(context).unfocus();
                  }),
              Observer(builder: (_) {
                return supportStore.msgErrorParticipantsSize == ""
                    ? Container()
                    : ErrorMsg(supportStore.msgErrorParticipantsSize);
              }),
              Observer(
                builder: (context) => ListView.builder(
                  shrinkWrap: true,
                  itemCount: supportStore.participantsLocal.length,
                  itemBuilder: (ctx, index) {
                    return CustomTextFormField(
                      textInputType: TextInputType.name,
                      onChanged: (value) =>
                          supportStore.updateParticipants(value, index),
                      initialValue: supportStore.participantsLocal[index],
                      hintText: "Nome Participante ${index + 1}",
                      labelText: 'Participante  ${index + 1}',
                    );
                  },
                ),
              ),
              CustomButton(
                text: "Criar Projeto",
                loadingText: "Criando projeto...",
                isLoading: supportStore.isLoading!,
                onPressed: () async {
                  if (supportStore.validateProjectMobileTab2()) {
                    supportStore.setLoading(true);
                    var result = await projectStore.addProject(
                        supportStore.title,
                        supportStore.pathImage,
                        supportStore.htmlContent,
                        supportStore.getTeachers(),
                        supportStore.getParticipantsLocalFilled(),
                        GlobalsVariables.username);
                    supportStore.setLoading(false);

                    if (result) {
                      CustomToast.showToast(
                          "Projeto cadastro com sucesso!!", Colors.green);
                      supportStore.clearData();
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
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/customButton_component.dart';
import 'package:site_historia/Components/customTextFormField_component.dart';
import 'package:site_historia/Components/erroMsg_component.dart';
import 'package:site_historia/Store/support_store.dart';

class ParticipantWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final supportStore = Provider.of<SupportStore>(context);
    final TextEditingController controllerParticipants =
        TextEditingController();
    return Column(
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
                  hintText: "Digite o numero de participantes (Max. 10)",
                  labelText: "Numero de participantes",
                  textInputAction: TextInputAction.next,
                ),
              ),
              Expanded(
                flex: 5,
                child: CustomButton(
                  text: "Gerar participantes",
                  onPressed: () => supportStore
                      .validateParticipant(controllerParticipants.text),
                ),
              ),
            ],
          ),
        ),
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
                hintText: "Nome Participante ${index + 1}",
                labelText: 'Participante  ${index + 1}',
              );
            },
          ),
        ),
      ],
    );
  }
}

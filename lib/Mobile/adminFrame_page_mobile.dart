/// Widget responsável por exibir a lista de quadros (Admin - versão mobile).
///
/// {@category Mobile}
/// {@subCategory Page}
// ignore: library_names
library AdminFramePageMobile;

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/widget/customText_component.dart';
import 'package:site_historia/Components/widget/customLoading_component.dart';
import 'package:site_historia/Mobile/widget/adminFrameCard_mobile.dart';
import 'package:site_historia/Model/frame_model.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Store/frame_store.dart';
import 'package:site_historia/Support/routesName_support.dart';
import 'package:velocity_x/velocity_x.dart';

/// Widget carrega todos os quadros através do método `getFrames()`. É composto pelo
/// widget `AdminFrameCardMobile(Frame quadro)` que monta a exibição de cada quadro.
class AdminFramePageMobile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final frameStore = Provider.of<FrameStore>(context);
    return Container(
      height: MediaQuery.of(context).size.height,
      child: Observer(builder: (ctx) {
        frameStore.listFrames ?? frameStore.getFrames();
        switch (frameStore.listFrames!.status) {
          case FutureStatus.pending:
            return CustomLoading();
          case FutureStatus.rejected:
            return ErrorLoad(
              color: Theme.of(context).primaryColor,
            );
          case FutureStatus.fulfilled:
            List<Frame> listFrames =
                frameStore.listFrames!.value as List<Frame>;
            return ListView(
              children: [
                Container(
                  margin: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      border: Border.all(
                          width: 1.0, color: Theme.of(context).primaryColor)),
                  child: ListTile(
                    leading: Icon(Icons.add_circle_rounded),
                    title: CustomText("Adicionar Quadro",isSelectable: false,
                        style: Theme.of(context).textTheme.bodyText1),
                    onTap: () => VxNavigator.of(context)
                        .push(Uri.parse(RouteNames.ADD_FRAME)),
                  ),
                ),
                for (int i = 0; i < listFrames.length; i++)
                  AdminFrameCardMobile(i),
              ],
            );
        }
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/CustomText_component.dart';
import 'package:site_historia/Components/widget/customLoading_component.dart';
import 'package:site_historia/Desktop/widget/adminFrameCard_desktop.dart';
import 'package:site_historia/Model/frame_model.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Store/frame_store.dart';
import 'package:site_historia/Support/routesName_support.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminFramePageDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final frameStore = Provider.of<FrameStore>(context);

    return Expanded(
      child: Container(
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
                          width: 1.0, color: Theme.of(context).primaryColor),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.add_circle_rounded),
                      title: CustomText("Adicionar Quadro",
                          style: Theme.of(context).textTheme.bodyText1),
                      onTap: () => VxNavigator.of(context)
                          .push(Uri.parse(RouteNames.ADD_FRAME)),
                    ),
                  ),
                  for (int i = 0; i < listFrames.length; i++) AdminFrameCardDesktop(i),
                ],
              );
          }
        }),
      ),
    );
  }
}

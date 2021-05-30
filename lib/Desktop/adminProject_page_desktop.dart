import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Components/CustomText_component.dart';
import 'package:site_historia/Components/widget/customLoading_component.dart';
import 'package:site_historia/Desktop/widget/adminProjectCard_desktop.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Store/project_store.dart';
import 'package:site_historia/Support/routesName_support.dart';
import 'package:site_historia/Model/project_model.dart';
import 'package:velocity_x/velocity_x.dart';

class AdminProjectPageDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final projectStore = Provider.of<ProjectStore>(context);

    return Expanded(
      child: Container(
        child: Observer(builder: (ctx) {
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
                      title: CustomText("Adicionar Projeto",
                          style: Theme.of(context).textTheme.bodyText1),
                      onTap: () => VxNavigator.of(context)
                          .push(Uri.parse(RouteNames.ADD_PROJECT)),
                    ),
                  ),
                  for (var project in listProjects)
                    AdminProjectCardDesktop(project),
                ],
              );
          }
        }),
      ),
    );
  }
}

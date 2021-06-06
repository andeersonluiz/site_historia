/// Tela responsável por exibir a página de atualizar Projeto (Admin).
///
/// {@category Screen}
// ignore: library_names
library AdminUpdateProjectScreen;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Components/widget/customLoading_component.dart';
import 'package:site_historia/Desktop/adminUpdateProject_page_desktop.dart';
import 'package:site_historia/Desktop/appBar/verticalAppBar_desktop.dart';
import 'package:site_historia/Mobile/adminUpdateProject_page_mobile.dart';
import 'package:site_historia/Mobile/drawer/adminNavigation_drawer_component.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Screens/loading_screen.dart';
import 'package:site_historia/Store/project_store.dart';
import 'package:site_historia/Model/project_model.dart';
import 'package:site_historia/Support/routesName_support.dart';

/// O Widget redireciona para duas telas diferentes, o desktop conta com o `VerticalAppBar` e a mobile
/// possui `AdminNavigatorDrawerMobile`. O método `getProjects()` é chamado  para
/// carregar as informações de projeto do banco de dados.
class AdminUpdateProjectScreen extends StatefulWidget {
  final String idProject;

  AdminUpdateProjectScreen(this.idProject);

  @override
  _AdminUpdateProjectScreenState createState() =>
      _AdminUpdateProjectScreenState();
}

class _AdminUpdateProjectScreenState extends State<AdminUpdateProjectScreen> {
  @override
  Widget build(BuildContext context) {
    final projectStore = Provider.of<ProjectStore>(context);
    return ResponsiveBuilder(
      builder: (ctx, sizingInformation) => Scaffold(
          drawer: sizingInformation.isDesktop ? null : AdminNavigatorDrawerMobile(),
          appBar: sizingInformation.isDesktop
              ? null
              : AppBar(
                  centerTitle: true,
                  title: Text("Editar Projeto"),
                ),
          body: Observer(builder: (_) {
            projectStore.listProjects ?? projectStore.getProjects();
            switch (projectStore.listProjects!.status) {
              case FutureStatus.pending:
                return Loading();
              case FutureStatus.rejected:
                return ErrorLoad(color: Theme.of(context).primaryColor);
              case FutureStatus.fulfilled:
                return FutureBuilder(
                  future: loadData(),
                  builder: (ctx, snp) {
                    if (snp.hasData) {
                      Project project = snp.data as Project;

                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: ScreenTypeLayout(
                            mobile: AdminUpdateProjectPageMobile(project),
                            desktop: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,

                                  children: [
                                VerticalAppBar(),
                                Expanded(
                                    child:
                                        AdminUpdateProjectPageDesktop(project)),
                              ]),
                            )),
                      );
                    } else if (snp.hasError) {
                      return Loading(
                        redirect: true,
                        to: RouteNames.ADMIN_PROJECTS,
                      );
                    } else {
                      return CustomLoading();
                    }
                  },
                );
            }
          })),
    );
  }

  loadData() async {
    final projectStore = Provider.of<ProjectStore>(context);
    return await projectStore.getProjectById(widget.idProject);
  }
}

/// Tela responsável por exibir as informações de projetos.
///
/// {@category Screen}
// ignore: library_names
library ProjectScreen;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Components/widget/customLoading_component.dart';
import 'package:site_historia/Desktop/appBar/custtomAppBar_desktop.dart';
import 'package:site_historia/Desktop/project_page_desktop.dart';
import 'package:site_historia/Mobile/project_page_mobile.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Screens/loading_screen.dart';
import 'package:site_historia/Store/project_store.dart';
import 'package:site_historia/Support/IconsData_support.dart';
import 'package:site_historia/Model/project_model.dart';
import 'package:site_historia/Support/routesName_support.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../Mobile/drawer/navigation_drawer_component.dart';

/// O Widget redireciona para duas telas diferentes, o desktop conta com o `CustomAppBarDesktop` e a mobile
/// possui `NavigationDrawer`. O método `getProjects()` é chamado para
/// carregar as informações de projetos do banco de dados. Possui um Widget para
/// desktop (`ProjectPageDesktop(Project projeto)`) e outro para mobile (`ProjectPageMobile(Project projeto)`).
class ProjectScreen extends StatefulWidget {
  final String idProject;
  ProjectScreen(this.idProject);
  @override
  _ProjectScreenState createState() => _ProjectScreenState();
}

class _ProjectScreenState extends State<ProjectScreen> {
  @override
  Widget build(BuildContext context) {
    final projectStore = Provider.of<ProjectStore>(context);

    final width = MediaQuery.of(context).size.width;
    return ResponsiveBuilder(
      builder: (ctx, sizingInformation) => Scaffold(
        endDrawer: sizingInformation.isDesktop ? null : NavigationDrawer(),
        appBar: sizingInformation.isDesktop
            ? null
            : AppBar(automaticallyImplyLeading: false, actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Icon(IconsData.LOGO_ICON, size: 30),
                ),
                Spacer(),
                Builder(
                  builder: (ctx) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                        icon: Icon(
                          Icons.menu,
                        ),
                        onPressed: () => Scaffold.of(ctx).openEndDrawer()),
                  ),
                ),
              ]),
        body: Observer(builder: (_) {
          projectStore.listProjects ?? projectStore.getProjects();
          switch (projectStore.listProjects!.status) {
            case FutureStatus.pending:
              return Loading();
            case FutureStatus.rejected:
              return ErrorLoad(
                color: Theme.of(context).primaryColor,
              );
            case FutureStatus.fulfilled:
              return FutureBuilder(
                  future: loadData(),
                  builder: (ctx, snp) {
                    if (snp.hasData) {
                      Project project = snp.data as Project;
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Title(
                          title: project.name,
                          color: Colors.black,
                          child: ScreenTypeLayout(
                              mobile: width > 600
                                  ? ProjectPageDesktop(project)
                                  : ProjectPageMobile(project),
                              desktop: StickyHeader(
                                  header: CustomAppBarDesktop(),
                                  content: ProjectPageDesktop(project))),
                        ),
                      );
                    } else if (snp.hasError) {
                      return Loading(
                        redirect: true,
                        to: RouteNames.HOME,
                      );
                    } else {
                      return CustomLoading();
                    }
                  });
          }
        }),
      ),
    );
  }

  loadData() async {
    final projectStore = Provider.of<ProjectStore>(context);
    return await projectStore.getProjectById(widget.idProject);
  }
}

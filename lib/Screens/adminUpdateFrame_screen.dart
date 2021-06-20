/// Tela responsável por exibir a página de atualizar Quadro (Admin).
///
/// {@category Screen}
// ignore: library_names
library AdminUpdateFrameScreen;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Components/widget/customLoading_component.dart';
import 'package:site_historia/Components/page/adminUpdateFrame_page.dart';
import 'package:site_historia/Desktop/appBar/verticalAppBar_desktop.dart';
import 'package:site_historia/Mobile/drawer/adminNavigation_drawer_component.dart';
import 'package:site_historia/Model/frame_model.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Screens/loading_screen.dart';
import 'package:site_historia/Store/frame_store.dart';
import 'package:site_historia/Support/routesName_support.dart';

/// O Widget redireciona para duas telas diferentes, o desktop conta com o `VerticalAppBar` e a mobile
/// possui `AdminNavigatorDrawerMobile`. O método `getFrames()` é chamado  para
/// carregar as informações de professor do banco de dados.
class AdminUpdateFrameScreen extends StatefulWidget {
  final String idFrame;

  AdminUpdateFrameScreen(this.idFrame);

  @override
  _AdminUpdateFrameScreenState createState() => _AdminUpdateFrameScreenState();
}

class _AdminUpdateFrameScreenState extends State<AdminUpdateFrameScreen> {
  @override
  Widget build(BuildContext context) {
    final frameStore = Provider.of<FrameStore>(context);

    return ResponsiveBuilder(
      builder: (ctx, sizingInformation) => Scaffold(
          drawer: sizingInformation.isDesktop ? null : AdminNavigatorDrawerMobile(),
          appBar: sizingInformation.isDesktop
              ? null
              : AppBar(
                  centerTitle: true,
                  title: SelectableText("Editar Quadro"),
                ),
          body: Observer(
            builder: (_) {
              frameStore.listFrames ?? frameStore.getFrames();
              switch (frameStore.listFrames!.status) {
                case FutureStatus.pending:
                  return Loading();
                case FutureStatus.rejected:
                  return ErrorLoad(color: Theme.of(context).primaryColor);
                case FutureStatus.fulfilled:
                  return FutureBuilder(
                    future: loadData(),
                    builder: (ctx, snp) {
                      if (snp.hasData) {
                        Frame frame = snp.data as Frame;
                        return SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: ScreenTypeLayout(
                              mobile: AdminUpdateFramePage(frame),
                              desktop: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                  VerticalAppBar(),
                                  Expanded(
                                      child:
                                          AdminUpdateFramePage(frame)),
                                ]),
                              )),
                        );
                      } else if (snp.hasError) {
                        return Loading(
                          redirect: true,
                          to: RouteNames.ADMIN_NOTICES,
                        );
                      } else {
                        return CustomLoading();
                      }
                    },
                  );
              }
            },
          )),
    );
  }

  loadData() async {
    final frameStore = Provider.of<FrameStore>(context);
    return await frameStore.getFrameById(widget.idFrame);
  }
}

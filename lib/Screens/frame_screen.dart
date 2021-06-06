/// Tela responsável por exibir as informações de quadros.
///
/// {@category Screen}
// ignore: library_names
library FrameScreen;
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Components/widget/customLoading_component.dart';
import 'package:site_historia/Desktop/appBar/custtomAppBar_desktop.dart';
import 'package:site_historia/Desktop/frame_page_desktop.dart';
import 'package:site_historia/Mobile/frame_page_mobile.dart';
import 'package:site_historia/Model/frame_model.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Screens/loading_screen.dart';
import 'package:site_historia/Store/frame_store.dart';
import 'package:site_historia/Support/IconsData_support.dart';
import 'package:site_historia/Support/routesName_support.dart';
import 'package:sticky_headers/sticky_headers.dart';
import '../Mobile/drawer/navigation_drawer_component.dart';

/// O Widget redireciona para duas telas diferentes, o desktop conta com o `CustomAppBarDesktop` e a mobile
/// possui `NavigationDrawer`. O método `getFrames()` é chamado para
/// carregar as informações de quadros do banco de dados. Possui um Widget para
/// desktop (`FramePageDesktop(Frame quadro)`) e outro para mobile (`FramePageMobile(Frame quadro)`).
class FrameScreen extends StatefulWidget {
  final String idFrame;
  FrameScreen(this.idFrame);
  @override
  _FrameScreenState createState() => _FrameScreenState();
}

class _FrameScreenState extends State<FrameScreen> {
  @override
  Widget build(BuildContext context) {
    final frameStore = Provider.of<FrameStore>(context);
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
          frameStore.listFrames ?? frameStore.getFrames();
          switch (frameStore.listFrames!.status) {
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
                      Frame frame = snp.data as Frame;
                      return Title(
                        title: frame.title,
                        color: Colors.black,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: ScreenTypeLayout(
                              mobile: FramePageMobile(frame),
                              desktop: StickyHeader(
                                  header: CustomAppBarDesktop(),
                                  content: FramePageDesktop(frame))),
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
    final frameStore = Provider.of<FrameStore>(context);
    return await frameStore.getFrameById(widget.idFrame);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:site_historia/Components/customLoading_component.dart';
import 'package:site_historia/Desktop/adminUpdateFrame_page_desktop.dart';
import 'package:site_historia/Desktop/appBar/verticalAppBar_desktop.dart';
import 'package:site_historia/Mobile/drawer/adminNavigation_drawer_component.dart';
import 'package:site_historia/Model/frame_model.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Screens/loading_screen.dart';
import 'package:site_historia/Store/frame_store.dart';
import 'package:site_historia/Support/RoutesName_support.dart';

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
          drawer: sizingInformation.isDesktop ? null : AdminNavigatorDrawer(),
          appBar: sizingInformation.isDesktop
              ? null
              : AppBar(
                  centerTitle: true,
                  title: Text("Editar Quadro"),
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
                              mobile: AdminUpdateFramePageDesktop(frame),
                              desktop: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height,
                                child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,

                                    children: [
                                  VerticalAppBar(),
                                  Expanded(
                                      child:
                                          AdminUpdateFramePageDesktop(frame)),
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

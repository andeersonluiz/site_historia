import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Screens/loading_screen.dart';
import 'package:site_historia/firebase/teacher_firestore.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:velocity_x/velocity_x.dart';
import 'Screens/about_screen.dart';
import 'Screens/home_screen.dart';
import 'Store/support_store.dart';
import 'Support/RoutesName_support.dart';
import 'Theme/ThemeConfig.dart';
import 'firebase/frame_firestore.dart';
import 'firebase/project_firestore.dart';

//Paleta Cores
//#572a1e (marrom escuro)
//#e07d5e (barro)
//#f3cfb8 (rosa claro)
//#ffffff (branco)
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  setPathUrlStrategy();
  runApp(MultiProvider(providers: [
    Provider<SupportStore>(
      create: (_) => SupportStore(),
    ),
    Provider<ProjectFirestore>(create: (_) => ProjectFirestore()),
    Provider<FrameFirestore>(create: (_) => FrameFirestore()),
    Provider<TeacherFirestore>(create: (_) => TeacherFirestore()),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProjectFirestore projectFirestore = Provider.of<ProjectFirestore>(context);

    return FutureBuilder(
      future: _loadInitialData(context),
      builder: (BuildContext context, AsyncSnapshot snp) {
        if (snp.hasError) {
          return MaterialApp(
            theme: ThemeConfig.theme,
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: ThemeConfig.brown,
              body: ErrorLoad(color: ThemeConfig.textColor),
            ),
          );
        } else if (snp.hasData) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Site Historia',
            theme: ThemeConfig.theme,
            routeInformationParser: VxInformationParser(),
            routerDelegate: VxNavigator(routes: {
              "/": (_, __) => MaterialPage(child: Home()),
              RouteNames.HOME: (_, __) => MaterialPage(child: Home()),
              RouteNames.ABOUT: (_, __) => MaterialPage(child: About()),
              RouteNames.PROJECTS: (uri, __) {
                final id = uri.queryParameters["id"];
                final project = projectFirestore.getProjectById(id.toString());//Pega a referencia do projeto
                return MaterialPage(child: Home());
              },
              RouteNames.NOTICES: (_, __) => MaterialPage(child: Home()),
              RouteNames.FRAMES: (_, __) => MaterialPage(child: Home()),
              RouteNames.EXAM: (_, __) => MaterialPage(child: Home()),
              RouteNames.RECOMENDATIONS: (_, __) => MaterialPage(child: Home()),
              RouteNames.COLLECTION: (_, __) => MaterialPage(child: Home()),
            }),
          );
        } else {
          return Loading();
        }
      },
    );
  }

  _loadInitialData(BuildContext context) async {
    ProjectFirestore projectFirestore = Provider.of<ProjectFirestore>(context);
    FrameFirestore frameFirestore = Provider.of<FrameFirestore>(context);
    await projectFirestore.getProjectsName();
    await frameFirestore.getFramesName();
    return [];
  }
}

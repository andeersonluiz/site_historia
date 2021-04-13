import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Screens/loading_screen.dart';
import 'package:site_historia/firebase/teacher_firestore.dart';
import 'Route/fluroRouter.dart';
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
  FluroRouting.setupRouter();
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
    return FutureBuilder(
      future: _loadInitialData(context),
      builder: (BuildContext context, AsyncSnapshot snp) {
        if (snp.hasError) {
          return MaterialApp(
            theme: ThemeConfig.theme,
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: ThemeConfig.brown,
              body: ErrorLoad(),
            ),
          );
        } else if (snp.hasData) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Site Historia',
            theme: ThemeConfig.theme,
            initialRoute: RouteNames.HOME,
            onGenerateRoute: FluroRouting.router.generator,
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

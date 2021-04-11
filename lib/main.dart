import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Screens/loading_screen.dart';

import 'Route/generateRoute_route.dart';
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
  runApp(MultiProvider(providers: [
    Provider<SupportStore>(
      create: (_) => SupportStore(),
    ),
    Provider<ProjectFirestore>(create: (_) => ProjectFirestore()),
    Provider<FrameFirestore>(create: (_) => FrameFirestore()),
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
            onGenerateRoute: RouteGenerator.generateRoute,
            initialRoute: RouteNames.HOME,
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
    print("foi");
    return [];
  }
}

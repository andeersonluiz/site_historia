import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Screens/adminAddProject_screen.dart';
import 'package:site_historia/Screens/adminProjects_screen.dart';
import 'package:site_historia/Screens/admin_screen.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Screens/loading_screen.dart';
import 'package:site_historia/Screens/project_screen.dart';
import 'package:site_historia/Support/vxNavigator.dart';
import 'package:site_historia/firebase/login_auth.dart';
import 'package:site_historia/firebase/teacher_firestore.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:velocity_x/velocity_x.dart';
import 'Screens/about_screen.dart';
import 'Screens/adminUpdateProject_screen.dart';
import 'Screens/home_screen.dart';
import 'Store/support_store.dart';
import 'Support/RoutesName_support.dart';
import 'Theme/ThemeConfig.dart';
import 'firebase/frame_firestore.dart';
import 'firebase/project_firestore.dart';
import 'package:firebase/firebase.dart';

import 'model/project_model.dart';

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



class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final username = "";
  var routes;


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    routes = VelocityxNavigator.getRoutes(context);
  }


  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    return FutureBuilder(
      future: _loadInitialData(context),
      builder: (BuildContext ctx, AsyncSnapshot snp) {
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
            routerDelegate:routes
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

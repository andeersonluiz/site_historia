import 'package:firebase/firebase.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Screens/loading_screen.dart';
import 'package:site_historia/Store/collection_store.dart';
import 'package:site_historia/Store/frame_store.dart';
import 'package:site_historia/Store/notice_store.dart';
import 'package:site_historia/Store/project_store.dart';
import 'package:site_historia/Store/recommendation_store.dart';
import 'package:site_historia/Store/teacher_store.dart';
import 'package:site_historia/Support/vxNavigator.dart';
import 'package:site_historia/firebase/login_auth.dart';
import 'package:site_historia/firebase/teacher_firestore.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:velocity_x/velocity_x.dart';
import 'Store/support_store.dart';
import 'Theme/themeConfig.dart';
import 'firebase/frame_firestore.dart';
import 'firebase/project_firestore.dart';

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
    Provider<ProjectStore>(
      create: (_) => ProjectStore(),
    ),
    Provider<TeacherStore>(
      create: (_) => TeacherStore(),
    ),
    Provider<NoticeStore>(
      create: (_) => NoticeStore(),
    ),
    Provider<FrameStore>(
      create: (_) => FrameStore(),
    ),
    Provider<RecommendationStore>(
      create: (_) => RecommendationStore(),
    ),
    Provider<CollectionStore>(
      create: (_) => CollectionStore(),
    )
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
    super.didChangeDependencies();
    routes = VelocityxNavigator.getRoutes(context);
  }

  @override
  Widget build(BuildContext context) {
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
              title: 'Coordenação de História CEFET/RJ',
              theme: ThemeConfig.theme,
              routeInformationParser: VxInformationParser(),
              routerDelegate: routes);
        } else {
          return Loading();
        }
      },
    );
  }

  _loadInitialData(BuildContext context) async {
    ProjectStore projectStore = Provider.of<ProjectStore>(context);
    FrameStore frameStore = Provider.of<FrameStore>(context);
    await projectStore.getProjectSortedByTitle();
    await frameStore.getFramesSortedByTitle();
    User? user = LoginAuth.getUser();
    if (user != null) {
      await projectStore.getUsernameByUid(user.uid);
    }
    return [];
  }
}

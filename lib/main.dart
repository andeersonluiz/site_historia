import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Screens/adminAddProject_screen.dart';
import 'package:site_historia/Screens/adminProjects_screen.dart';
import 'package:site_historia/Screens/admin_screen.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Screens/loading_screen.dart';
import 'package:site_historia/Screens/project_screen.dart';
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

class MyApp extends StatelessWidget {
  final username = "";
  @override
  Widget build(BuildContext context) {
    ProjectFirestore projectFirestore = Provider.of<ProjectFirestore>(context);

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
            routerDelegate: VxNavigator(
                notFoundPage: (_, __) {
                  return MaterialPage(
                      child: Loading(
                    redirect: true,
                  ));
                },
                routes: {
                  "/": (_, __) {
                    if (Uri.base.path != "/") {
                      return MaterialPage(
                        child: Loading(),
                      );
                    } else {
                      return MaterialPage(
                        child: Loading(
                          redirect: true,
                        ),
                      );
                    }
                  },
                  RouteNames.HOME: (_, __) {
                    return MaterialPage(
                      child: HomeScreen(),
                    );
                  },
                  RouteNames.ABOUT: (_, __) =>
                      MaterialPage(child: AboutScreen()),
                  RouteNames.PROJECTS: (uri, __) {
                    final id = uri.queryParameters["id"];
                    if (id == null) {
                      return MaterialPage(
                          child: Loading(
                        redirect: true,
                      ));
                    }

                    final project = projectFirestore.getProjectById(
                        id.toString()); //Pega a referencia do projeto
                    return MaterialPage(child: ProjectScreen(project));
                  },
                  RouteNames.NOTICES: (_, __) =>
                      MaterialPage(child: HomeScreen()),
                  RouteNames.FRAMES: (_, __) =>
                      MaterialPage(child: HomeScreen()),
                  RouteNames.EXAM: (_, __) => MaterialPage(child: HomeScreen()),
                  RouteNames.RECOMENDATIONS: (_, __) =>
                      MaterialPage(child: HomeScreen()),
                  RouteNames.COLLECTION: (_, __) =>
                      MaterialPage(child: HomeScreen()),
                  RouteNames.ADMIN: (_, __) {
                    User? user = LoginAuth.getUser();
                    if (user == null) {
                      return MaterialPage(child: AdminScreen());
                    } else {
                      return MaterialPage(
                          child: Loading(
                              redirect: true, to: RouteNames.ADMIN_INFO));
                    }
                  },
                  RouteNames.ADMIN_INFO: (uri, __) {
                    User? user = LoginAuth.getUser();
                    if (user == null) {
                      return MaterialPage(
                          child: Loading(redirect: true, to: RouteNames.ADMIN));
                    } else {
                      return MaterialPage(child: AdminProjectsScreen(user.uid));
                    }
                  },
                  RouteNames.ADD_PROJECT: (uri, __) {
                    User? user = LoginAuth.getUser();
                    if (user == null) {
                      return MaterialPage(
                          child: Loading(redirect: true, to: RouteNames.ADMIN));
                    } else {
                      return MaterialPage(
                        child: AdminAddProjectScreen(user.uid),
                      );
                    }
                  },
                  RouteNames.UPDATE_PROJECT: (uri, params) {
                    User? user = LoginAuth.getUser();
                    if (user == null) {
                      return MaterialPage(
                          child: Loading(redirect: true, to: RouteNames.ADMIN));
                    } else {
                      String? id = uri.queryParameters["id"];
                      if (id == null) {
                        id = params['id'] as String?;
                      }
                      final Project project =
                          projectFirestore.getProjectById(id);
                      return MaterialPage(
                          child: AdminUpdateProjectScreen(project, user.uid));
                    }
                  },
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

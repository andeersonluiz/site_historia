import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Screens/adminAddNotice_screen.dart';
import 'package:site_historia/Screens/adminAddProject_screen.dart';
import 'package:site_historia/Screens/adminNotices_screen.dart';
import 'package:site_historia/Screens/adminProjects_screen.dart';
import 'package:site_historia/Screens/adminUpdateProject_screen.dart';
import 'package:site_historia/Screens/admin_screen.dart';
import 'package:site_historia/Screens/home_screen.dart';
import 'package:site_historia/Screens/loading_screen.dart';
import 'package:site_historia/Screens/project_screen.dart';
import 'package:site_historia/Store/notice_store.dart';
import 'package:site_historia/Store/project_store.dart';
import 'package:site_historia/Support/RoutesName_support.dart';
import 'package:site_historia/firebase/login_auth.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:site_historia/Screens/about_screen.dart';
import 'package:firebase/firebase.dart';

class VelocityxNavigator {
  static RouterDelegate<Object> getRoutes(BuildContext context) {
    ProjectStore projectStore = Provider.of<ProjectStore>(context);
    NoticeStore noticeStore = Provider.of<NoticeStore>(context);

    return VxNavigator(
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
            key: ValueKey(RouteNames.HOME),
            child: HomeScreen(),
          );
        },
        RouteNames.ABOUT: (_, __) => MaterialPage(child: AboutScreen()),
        RouteNames.PROJECTS: (uri, __) {
          String? id = uri.queryParameters["id"];
          if (id == null || int.tryParse(id) == null || id == "") {
            return MaterialPage(
                child: Loading(
              redirect: true,
            ));
          }

          final project = projectStore
              .getProjectById(id.toString()); //Pega a referencia do projeto
          if (project == null) {
            return MaterialPage(
                child: Loading(
              redirect: true,
            ));
          }
          return MaterialPage(child: ProjectScreen(project));
        },
        RouteNames.NOTICES: (_, __) => MaterialPage(child: HomeScreen()),
        RouteNames.FRAMES: (_, __) => MaterialPage(child: HomeScreen()),
        RouteNames.EXAM: (_, __) => MaterialPage(child: HomeScreen()),
        RouteNames.RECOMENDATIONS: (_, __) => MaterialPage(child: HomeScreen()),
        RouteNames.COLLECTION: (_, __) => MaterialPage(child: HomeScreen()),
        RouteNames.ADMIN: (_, __) {
          User? user = LoginAuth.getUser();
          if (user == null) {
            return MaterialPage(
                key: ValueKey(RouteNames.ADMIN), child: AdminScreen());
          } else {
            return MaterialPage(
                child: Loading(redirect: true, to: RouteNames.ADMIN_PROJECTS));
          }
        },
        RouteNames.ADMIN_PROJECTS: (uri, __) {
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

            if (id == null || int.tryParse(id) == null || id == "") {
              return MaterialPage(
                  child: Loading(
                redirect: true,
                to: RouteNames.ADMIN_PROJECTS,
              ));
            }

            final project = projectStore.getProjectById(id);
            if (project == null) {
              return MaterialPage(
                  child: Loading(
                redirect: true,
                to: RouteNames.ADMIN_PROJECTS,
              ));
            }

            return MaterialPage(
                child: AdminUpdateProjectScreen(project, user.uid));
          }
        },
        RouteNames.ADMIN_NOTICES: (uri, params) {
          User? user = LoginAuth.getUser();
          if (user == null) {
            return MaterialPage(
                child: Loading(redirect: true, to: RouteNames.ADMIN));
          } else {
            return MaterialPage(child: AdminNoticesScreen(user.uid));
          }
        },
        RouteNames.ADD_NOTICE: (uri, __) {
          User? user = LoginAuth.getUser();
          if (user == null) {
            return MaterialPage(
                child: Loading(redirect: true, to: RouteNames.ADMIN));
          } else {
            return MaterialPage(
              child: AdminAddNoticeScreen(user.uid),
            );
          }
        },
        RouteNames.UPDATE_NOTICE: (uri, params) {
          User? user = LoginAuth.getUser();
          if (user == null) {
            return MaterialPage(
                child: Loading(redirect: true, to: RouteNames.ADMIN));
          } else {
            String? id = uri.queryParameters["id"];

            if (id == null || int.tryParse(id) == null || id == "") {
              return MaterialPage(
                  child: Loading(
                redirect: true,
                to: RouteNames.ADMIN_PROJECTS,
              ));
            }

            final notice = noticeStore.getNoticeById(id);
            if (notice == null) {
              return MaterialPage(
                  child: Loading(
                redirect: true,
                to: RouteNames.ADMIN_PROJECTS,
              ));
            }

            return MaterialPage(
                child: Loading(
              redirect: true,
              to: RouteNames.ADMIN_PROJECTS,
            ));
          }
        },
      },
    );
  }
}

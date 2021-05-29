import 'package:flutter/material.dart';
import 'package:site_historia/Screens/adminAddFrame_screen.dart';
import 'package:site_historia/Screens/adminAddTeacher_screen.dart';
import 'package:site_historia/Screens/adminFrames_screen.dart';
import 'package:site_historia/Screens/adminRecommendation_screen.dart';
import 'package:site_historia/Screens/adminTeachers_screen.dart';
import 'package:site_historia/Screens/adminUpdateFrame_screen.dart';
import 'package:site_historia/Screens/adminUpdateTeacher_screen.dart';
import 'package:site_historia/Screens/frame_screen.dart';
import 'package:site_historia/Screens/noticeInfo_screen.dart';
import 'package:site_historia/Screens/adminAddNotice_screen.dart';
import 'package:site_historia/Screens/adminAddProject_screen.dart';
import 'package:site_historia/Screens/adminNotices_screen.dart';
import 'package:site_historia/Screens/adminProjects_screen.dart';
import 'package:site_historia/Screens/adminUpdateNotice_screen.dart';
import 'package:site_historia/Screens/adminUpdateProject_screen.dart';
import 'package:site_historia/Screens/admin_screen.dart';
import 'package:site_historia/Screens/home_screen.dart';
import 'package:site_historia/Screens/loading_screen.dart';
import 'package:site_historia/Screens/notice_screen.dart';
import 'package:site_historia/Screens/project_screen.dart';
import 'package:site_historia/Screens/recommendations_screen.dart';
import 'package:site_historia/Support/RoutesName_support.dart';
import 'package:site_historia/firebase/login_auth.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:site_historia/Screens/about_screen.dart';
import 'package:firebase/firebase.dart';

class VelocityxNavigator {
  static RouterDelegate<Object> getRoutes(BuildContext context) {
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

          return MaterialPage(child: ProjectScreen(id));
        },
        RouteNames.NOTICES: (uri, __) {
          final id = uri.queryParameters['id'];
          if (id == null || int.tryParse(id) == null || id == "") {
            return MaterialPage(child: NoticeScreen());
          }

          return MaterialPage(child: NoticeInfoScreen(id));
        },
        RouteNames.FRAMES: (uri, __) {
          String? id = uri.queryParameters["id"];
          if (id == null || int.tryParse(id) == null || id == "") {
            return MaterialPage(
                child: Loading(
              redirect: true,
            ));
          }
          return MaterialPage(child: FrameScreen(id));
        },
        RouteNames.EXAM: (_, __) => MaterialPage(child: HomeScreen()),
        RouteNames.RECOMMENDATIONS: (_, __) =>
            MaterialPage(child: RecommendationScreen()),
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
            return MaterialPage(child: AdminProjectsScreen());
          }
        },
        RouteNames.ADD_PROJECT: (uri, __) {
          User? user = LoginAuth.getUser();
          if (user == null) {
            return MaterialPage(
                child: Loading(redirect: true, to: RouteNames.ADMIN));
          } else {
            return MaterialPage(
              child: AdminAddProjectScreen(),
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

            return MaterialPage(child: AdminUpdateProjectScreen(id));
          }
        },
        RouteNames.ADMIN_NOTICES: (uri, params) {
          User? user = LoginAuth.getUser();
          if (user == null) {
            return MaterialPage(
                child: Loading(redirect: true, to: RouteNames.ADMIN));
          } else {
            return MaterialPage(child: AdminNoticesScreen());
          }
        },
        RouteNames.ADD_NOTICE: (uri, __) {
          User? user = LoginAuth.getUser();
          if (user == null) {
            return MaterialPage(
                child: Loading(redirect: true, to: RouteNames.ADMIN));
          } else {
            return MaterialPage(
              child: AdminAddNoticeScreen(),
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
                to: RouteNames.ADMIN_NOTICES,
              ));
            }

            return MaterialPage(child: AdminUpdateNoticeScreen(id));
          }
        },
        RouteNames.ADMIN_FRAMES: (uri, params) {
          User? user = LoginAuth.getUser();
          if (user == null) {
            return MaterialPage(
                child: Loading(redirect: true, to: RouteNames.ADMIN));
          } else {
            return MaterialPage(child: AdminFramesScreen());
          }
        },
        RouteNames.ADD_FRAME: (uri, __) {
          User? user = LoginAuth.getUser();
          if (user == null) {
            return MaterialPage(
                child: Loading(redirect: true, to: RouteNames.ADMIN));
          } else {
            return MaterialPage(
              child: AdminAddFrameScreen(),
            );
          }
        },
        RouteNames.UPDATE_FRAME: (uri, params) {
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
                to: RouteNames.ADMIN_FRAMES,
              ));
            }

            return MaterialPage(child: AdminUpdateFrameScreen(id));
          }
        },
        RouteNames.ADMIN_TEACHERS: (uri, params) {
          User? user = LoginAuth.getUser();
          if (user == null) {
            return MaterialPage(
                child: Loading(redirect: true, to: RouteNames.ADMIN));
          } else {
            return MaterialPage(child: AdminTeachersScreen());
          }
        },
        RouteNames.ADD_TEACHER: (uri, __) {
          User? user = LoginAuth.getUser();
          if (user == null) {
            return MaterialPage(
                child: Loading(redirect: true, to: RouteNames.ADMIN));
          } else {
            return MaterialPage(
              child: AdminAddTeacherScreen(),
            );
          }
        },
        RouteNames.UPDATE_TEACHER: (uri, params) {
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
                to: RouteNames.ADMIN_TEACHERS,
              ));
            }

            return MaterialPage(child: AdminUpdateTeacherScreen(id));
          }
        },
        RouteNames.ADMIN_RECOMMENDATIONS: (uri, params) {
          User? user = LoginAuth.getUser();
          if (user == null) {
            return MaterialPage(
                child: Loading(redirect: true, to: RouteNames.ADMIN));
          } else {
            return MaterialPage(child: AdminRecommendationScreen());
          }
        },
      },
    );
  }
}

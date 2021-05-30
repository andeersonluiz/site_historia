import 'package:flutter/material.dart';
import 'package:site_historia/Screens/adminAddFrame_screen.dart';
import 'package:site_historia/Screens/adminAddTeacher_screen.dart';
import 'package:site_historia/Screens/adminCollection_screen.dart';
import 'package:site_historia/Screens/adminFrames_screen.dart';
import 'package:site_historia/Screens/adminRecommendation_screen.dart';
import 'package:site_historia/Screens/adminTeachers_screen.dart';
import 'package:site_historia/Screens/adminUpdateFrame_screen.dart';
import 'package:site_historia/Screens/adminUpdateTeacher_screen.dart';
import 'package:site_historia/Screens/collections_screen.dart';
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
import 'package:site_historia/Support/titleNames_support.dart';
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
              child: Title(
                  title: "Coordenação de História CEFET/RJ",
                  color: Colors.black,
                  child: Loading()),
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
            child: Title(
                title: TitleNames.HOME,
                color: Colors.black,
                child: HomeScreen()),
          );
        },
        RouteNames.ABOUT: (_, __) => MaterialPage(
            child: Title(
                title: TitleNames.ABOUT,
                color: Colors.black,
                child: AboutScreen())),
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
            return MaterialPage(
                child: Title(
                    title: TitleNames.NOTICES,
                    color: Colors.black,
                    child: NoticeScreen()));
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
        RouteNames.EXAM: (_, __) => MaterialPage(
            child: Title(
                title: TitleNames.EXAM,
                color: Colors.black,
                child: HomeScreen())),
        RouteNames.RECOMMENDATIONS: (_, __) => MaterialPage(
            child: Title(
                title: TitleNames.RECOMMENDATIONS,
                color: Colors.black,
                child: RecommendationScreen())),
        RouteNames.COLLECTION: (_, __) => MaterialPage(
            child: Title(
                title: TitleNames.COLLECTION,
                color: Colors.black,
                child: CollectionScreen())),
        RouteNames.ADMIN: (_, __) {
          User? user = LoginAuth.getUser();
          if (user == null) {
            return MaterialPage(
                key: ValueKey(RouteNames.ADMIN),
                child: Title(
                    title: TitleNames.ADMIN,
                    color: Colors.black,
                    child: AdminScreen()));
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
            return MaterialPage(
                child: Title(
                    title: TitleNames.ADMIN_PROJECTS,
                    color: Colors.black,
                    child: AdminProjectsScreen()));
          }
        },
        RouteNames.ADD_PROJECT: (uri, __) {
          User? user = LoginAuth.getUser();
          if (user == null) {
            return MaterialPage(
                child: Loading(redirect: true, to: RouteNames.ADMIN));
          } else {
            return MaterialPage(
              child: Title(
                  title: TitleNames.ADD_PROJECT,
                  color: Colors.black,
                  child: AdminAddProjectScreen()),
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

            return MaterialPage(
                child: Title(
                    title: TitleNames.UPDATE_PROJECT,
                    color: Colors.black,
                    child: AdminUpdateProjectScreen(id)));
          }
        },
        RouteNames.ADMIN_NOTICES: (uri, params) {
          User? user = LoginAuth.getUser();
          if (user == null) {
            return MaterialPage(
                child: Loading(redirect: true, to: RouteNames.ADMIN));
          } else {
            return MaterialPage(
                child: Title(
                    title: TitleNames.ADMIN_NOTICES,
                    color: Colors.black,
                    child: AdminNoticesScreen()));
          }
        },
        RouteNames.ADD_NOTICE: (uri, __) {
          User? user = LoginAuth.getUser();
          if (user == null) {
            return MaterialPage(
                child: Loading(redirect: true, to: RouteNames.ADMIN));
          } else {
            return MaterialPage(
              child: Title(
                  title: TitleNames.ADD_NOTICE,
                  color: Colors.black,
                  child: AdminAddNoticeScreen()),
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

            return MaterialPage(
                child: Title(
                    title: TitleNames.UPDATE_NOTICE,
                    color: Colors.black,
                    child: AdminUpdateNoticeScreen(id)));
          }
        },
        RouteNames.ADMIN_FRAMES: (uri, params) {
          User? user = LoginAuth.getUser();
          if (user == null) {
            return MaterialPage(
                child: Loading(redirect: true, to: RouteNames.ADMIN));
          } else {
            return MaterialPage(
                child: Title(
                    title: TitleNames.ADMIN_FRAMES,
                    color: Colors.black,
                    child: AdminFramesScreen()));
          }
        },
        RouteNames.ADD_FRAME: (uri, __) {
          User? user = LoginAuth.getUser();
          if (user == null) {
            return MaterialPage(
                child: Loading(redirect: true, to: RouteNames.ADMIN));
          } else {
            return MaterialPage(
              child: Title(
                  title: TitleNames.ADD_FRAME,
                  color: Colors.black,
                  child: AdminAddFrameScreen()),
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

            return MaterialPage(
                child: Title(
                    title: TitleNames.UPDATE_FRAME,
                    color: Colors.black,
                    child: AdminUpdateFrameScreen(id)));
          }
        },
        RouteNames.ADMIN_TEACHERS: (uri, params) {
          User? user = LoginAuth.getUser();
          if (user == null) {
            return MaterialPage(
                child: Loading(redirect: true, to: RouteNames.ADMIN));
          } else {
            return MaterialPage(
                child: Title(
                    title: TitleNames.ADMIN_TEACHERS,
                    color: Colors.black,
                    child: AdminTeachersScreen()));
          }
        },
        RouteNames.ADD_TEACHER: (uri, __) {
          User? user = LoginAuth.getUser();
          if (user == null) {
            return MaterialPage(
                child: Loading(redirect: true, to: RouteNames.ADMIN));
          } else {
            return MaterialPage(
              child: Title(
                  title: TitleNames.ADD_TEACHER,
                  color: Colors.black,
                  child: AdminAddTeacherScreen()),
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

            return MaterialPage(
                child: Title(
                    title: TitleNames.UPDATE_TEACHER,
                    color: Colors.black,
                    child: AdminUpdateTeacherScreen(id)));
          }
        },
        RouteNames.ADMIN_RECOMMENDATIONS: (uri, params) {
          User? user = LoginAuth.getUser();
          if (user == null) {
            return MaterialPage(
                child: Loading(redirect: true, to: RouteNames.ADMIN));
          } else {
            return MaterialPage(
                child: Title(
                    title: TitleNames.ADMIN_RECOMMENDATIONS,
                    color: Colors.black,
                    child: AdminRecommendationScreen()));
          }
        },
        RouteNames.ADMIN_COLLECTIONS: (uri, params) {
          User? user = LoginAuth.getUser();
          if (user == null) {
            return MaterialPage(
                child: Loading(redirect: true, to: RouteNames.ADMIN));
          } else {
            return MaterialPage(
                child: Title(
                    title: TitleNames.ADMIN_COLLECTIONS,
                    color: Colors.black,
                    child: AdminCollectionScreen()));
          }
        },
      },
    );
  }
}

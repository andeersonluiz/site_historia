import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_historia/Screens/adminAddProject_screen.dart';
import 'package:site_historia/Screens/adminProjects_screen.dart';
import 'package:site_historia/Screens/adminUpdateProject_screen.dart';
import 'package:site_historia/Screens/admin_screen.dart';
import 'package:site_historia/Screens/errorLoad_screen.dart';
import 'package:site_historia/Screens/home_screen.dart';
import 'package:site_historia/Screens/loading_screen.dart';
import 'package:site_historia/Screens/project_screen.dart';
import 'package:site_historia/Support/RoutesName_support.dart';
import 'package:site_historia/firebase/login_auth.dart';
import 'package:site_historia/firebase/project_firestore.dart';
import 'package:site_historia/firebase/teacher_firestore.dart';
import 'package:url_strategy/url_strategy.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:site_historia/Screens/about_screen.dart';
import 'package:firebase/firebase.dart';


class VelocityxNavigator{

  static RouterDelegate<Object> getRoutes(BuildContext context){
    ProjectFirestore projectFirestore = Provider.of<ProjectFirestore>(context);

    return VxNavigator(
        notFoundPage: (_, __) {
          print("nofoundpage");

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
              key:  ValueKey( RouteNames.HOME),
              child: HomeScreen(),
            );
          },
          RouteNames.ABOUT: (_, __) =>
              MaterialPage(child: AboutScreen()),
          RouteNames.PROJECTS: (uri, __) {
            String? id = uri.queryParameters["id"];
            if (id == null || int.tryParse(id)==null || id=="") {
              return MaterialPage(
                  child: Loading(
                    redirect: true,
                  ));
            }

            final project = projectFirestore.getProjectById(
                id.toString()); //Pega a referencia do projeto
            if (project == null) {
              return MaterialPage(
                  child: Loading(
                    redirect: true,
                  ));
            }
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
            print(user);
            if (user == null) {
              return MaterialPage(
                  key: ValueKey( RouteNames.ADMIN),
                  child: AdminScreen());
            } else {
              print("ff");
              return MaterialPage(
                  child: Loading(
                      redirect: true, to: RouteNames.ADMIN_PROJECTS));
            }
          },
          RouteNames.ADMIN_PROJECTS: (uri, __) {
            User? user = LoginAuth.getUser();
            print("ooi");
            if (user == null) {
              print("user null $user");
              return MaterialPage(
                  child: Loading(redirect: true, to: RouteNames.ADMIN));
            } else {
              print("cheguei");
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
            print("updateee");
            if (user == null) {
              return MaterialPage(
                  child: Loading(redirect: true, to: RouteNames.ADMIN));
            } else {
              String? id = uri.queryParameters["id"];

              if (id == null || int.tryParse(id)==null || id=="") {
                return MaterialPage(
                    child: Loading(
                      redirect: true,
                      to: RouteNames.ADMIN_PROJECTS,
                    ));
              }

              final project = projectFirestore.getProjectById(id);
              print("project $project");
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
        });
  }
}
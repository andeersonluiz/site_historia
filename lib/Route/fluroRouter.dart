import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:site_historia/Screens/about_screen.dart';
import 'package:site_historia/Screens/home_screen.dart';
import 'package:site_historia/Support/RoutesName_support.dart';

class FluroRouting {
  static FluroRouter router = FluroRouter();
  static Handler _homeHandler =
      Handler(handlerFunc: (context, params) => Home());
  static Handler _aboutHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          About());
  static Handler _projectHandler =
      Handler(handlerFunc: (context, params) => Home());
  static Handler _noticesHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          Home());
  static Handler _framesHandler =
      Handler(handlerFunc: (context, params) => Home());
  static Handler _examHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          Home());
  static Handler _recomendationHandler =
      Handler(handlerFunc: (context, params) => Home());
  static Handler _collectionHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) =>
          Home());

  static void setupRouter() {
    router.define(
      "/",
      handler: _homeHandler,
    );
    router.define(
      RouteNames.HOME,
      handler: _homeHandler,
    );
    router.define(
      RouteNames.ABOUT,
      handler: _aboutHandler,
    );
    router.define(
      RouteNames.PROJECTS + "/:name",
      handler: _homeHandler,
    );
    router.define(
      RouteNames.NOTICES,
      handler: _aboutHandler,
    );
    router.define(
      RouteNames.FRAMES + "/:name",
      handler: _homeHandler,
    );
    router.define(
      RouteNames.EXAM,
      handler: _aboutHandler,
    );
    router.define(
      RouteNames.RECOMENDATIONS,
      handler: _homeHandler,
    );
    router.define(
      RouteNames.COLLECTION,
      handler: _aboutHandler,
    );
  }
}

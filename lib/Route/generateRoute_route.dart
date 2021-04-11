import 'package:flutter/cupertino.dart';
import 'generatePageRoute_route.dart';
import '../Screens/home_screen.dart';
import '../Support/RoutesName_support.dart';
import '../model/Frame_model.dart';
import '../model/project_model.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteNames.HOME:
        return GeneratePageRoute(Home(), RouteNames.HOME);
      case RouteNames.ABOUT:
        return GeneratePageRoute(Home(), RouteNames.HOME);
      case RouteNames.PROJECTS:
        Project project = settings.arguments as Project;
        return GeneratePageRoute(Home(), RouteNames.HOME);
      case RouteNames.NOTICES:
        return GeneratePageRoute(Home(), RouteNames.HOME);
      case RouteNames.FRAMES:
        Frame frame = settings.arguments as Frame;
        return GeneratePageRoute(Home(), RouteNames.HOME);
      case RouteNames.EXAM:
        return GeneratePageRoute(Home(), RouteNames.HOME);
      case RouteNames.RECOMENDATIONS:
        return GeneratePageRoute(Home(), RouteNames.HOME);
      case RouteNames.COLLECTION:
        return GeneratePageRoute(Home(), RouteNames.HOME);
    }
    return GeneratePageRoute(Container(), RouteNames.HOME);
  }
}

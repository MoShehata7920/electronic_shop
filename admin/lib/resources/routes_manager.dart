import 'package:admin_panel/resources/strings_manager.dart';
import 'package:admin_panel/screens/dashboard/dashboard_screen.dart';
import 'package:flutter/material.dart';



class Routes {
  static const String dashBoardRoute = "/";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.dashBoardRoute:
        return MaterialPageRoute(builder: (context) => const DashboardScreen());

      
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (context) => Scaffold(
              appBar: AppBar(
                title: Text(AppStrings.noRouteTitle),
              ),
              body: Center(child: Text(AppStrings.noRouteFound)),
            ));
  }
}

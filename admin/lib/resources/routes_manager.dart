import 'package:admin_panel/resources/strings_manager.dart';
import 'package:admin_panel/screens/add_product/add_product_screen.dart';
import 'package:admin_panel/screens/dashboard/dashboard_screen.dart';
import 'package:admin_panel/screens/view_all_orders/view_all_orders_screen.dart';
import 'package:admin_panel/screens/view_all_products/view_all_products_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String dashBoardRoute = "/";
  static const String viewAllProductsScreenRoute =
      "/viewAllProductsScreenRoute";
  static const String viewAllOrdersScreenRoute = "/viewAllOrdersScreenRoute";
  static const String addProductScreenRoute = "/addProductScreenRoute";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.dashBoardRoute:
        return MaterialPageRoute(builder: (context) => const DashboardScreen());

      case Routes.viewAllProductsScreenRoute:
        return MaterialPageRoute(
            builder: (context) => const ViewAllProductsScreen());

      case Routes.viewAllOrdersScreenRoute:
        return MaterialPageRoute(
            builder: (context) => const ViewAllOrdersScreen());

      case Routes.addProductScreenRoute:
        return MaterialPageRoute(
            builder: (context) => const AddProductScreen());

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

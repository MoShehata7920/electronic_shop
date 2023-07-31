import 'package:electronic_shop/resources/strings_manager.dart';
import 'package:electronic_shop/screens/home/feeds_screen/feeds_screen.dart';
import 'package:electronic_shop/screens/home/home_screen.dart';
import 'package:electronic_shop/screens/home/on_sale_products_screen/on_sale_products_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String homeRoute = "/";
  static const String onSaleProductsScreenRoute = "/onSaleProductsScreen";
  static const String feedsScreenRoute = "/feedsScreenRoute";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeRoute:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      case Routes.onSaleProductsScreenRoute:
        return MaterialPageRoute(
            builder: (context) => const OnSaleProductsScreen());

      case Routes.feedsScreenRoute:
        return MaterialPageRoute(builder: (context) => const FeedsScreen());

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

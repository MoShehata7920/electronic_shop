import 'package:electronic_shop/resources/strings_manager.dart';
import 'package:electronic_shop/screens/auth/forgot_password/forgot_password.dart';
import 'package:electronic_shop/screens/home/feeds_screen/feeds_screen.dart';
import 'package:electronic_shop/screens/home/home_screen.dart';
import 'package:electronic_shop/screens/home/on_sale_products_screen/on_sale_products_screen.dart';
import 'package:electronic_shop/screens/main_screen.dart';
import 'package:electronic_shop/screens/product_screen/product_screen.dart';
import 'package:electronic_shop/screens/settings/inner_settings_screens/recently_viewed/recently_viewed_screen.dart';
import 'package:electronic_shop/screens/settings/inner_settings_screens/wish_list/wish_list_screen.dart';
import 'package:electronic_shop/screens/settings/inner_settings_screens/your_orders/orders_screen.dart';
import 'package:flutter/material.dart';
import '../screens/auth/login/login.dart';
import '../screens/auth/sign_up/sign_up.dart';
import '../screens/categories/category_screen.dart';

class Routes {
  static const String splash = "/";
  static const String mainScreenRoute = "/mainScreenRoute";
  static const String homeRoute = "/homeRoute";
  static const String categoriesScreenRoute = "/categoriesScreenRoute";
  static const String cartScreenRoute = "/cartScreenRoute";
  static const String settingsScreenRoute = "/settingsScreenRoute";
  static const String onSaleProductsScreenRoute = "/onSaleProductsScreen";
  static const String feedsScreenRoute = "/feedsScreenRoute";
  static const String productScreenRoute = "/productScreenRoute";
  static const String wishListScreenRoute = "/wishListScreenRoute";
  static const String recentlyViewedProductsScreenRoute = "/recentlyViewedProductsScreenRoute";
  static const String ordersScreenRoute = "/ordersProductsScreenRoute";
  static const String loginScreenRoute = "/loginScreenRoute";
  static const String signUpScreenRoute = "/signUpScreenRoute";
  static const String forgotPasswordScreenRoute = "/forgotPasswordScreenRoute";
  static const String categoryScreenRoute = "/categoryScreenRoute";
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.mainScreenRoute:
        return MaterialPageRoute(builder: (context) => const MainScreen());

      case Routes.homeRoute:
        return MaterialPageRoute(builder: (context) => const HomeScreen());

      case Routes.onSaleProductsScreenRoute:
        return MaterialPageRoute(
            builder: (context) => const OnSaleProductsScreen());

      case Routes.feedsScreenRoute:
        return MaterialPageRoute(builder: (context) => const FeedsScreen());

      case Routes.productScreenRoute:
        return MaterialPageRoute(
            builder: (context) => ProductScreen(settings.arguments));

      case Routes.wishListScreenRoute:
        return MaterialPageRoute(builder: (context) => const WishListScreen());

      case Routes.recentlyViewedProductsScreenRoute:
        return MaterialPageRoute(builder: (context) => const RecentlyViewedScreen());

      case Routes.ordersScreenRoute:
        return MaterialPageRoute(builder: (context) => const OrdersScreen());

      case Routes.loginScreenRoute:
        return MaterialPageRoute(builder: (context) => const LoginScreen());

      case Routes.signUpScreenRoute:
        return MaterialPageRoute(builder: (context) => const SignUpScreen());

      case Routes.forgotPasswordScreenRoute:
        return MaterialPageRoute(
            builder: (context) => const ForgotPasswordScreen());

      case Routes.categoryScreenRoute:
        return MaterialPageRoute(
            builder: (context) => CategoryScreen(settings.arguments));

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

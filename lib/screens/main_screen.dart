import 'package:electronic_shop/resources/icons_manager.dart';
import 'package:electronic_shop/resources/strings_manager.dart';
import 'package:electronic_shop/resources/values_manager.dart';
import 'package:electronic_shop/screens/cart/cart_screen.dart';
import 'package:electronic_shop/screens/categories/categories_screen.dart';
import 'package:electronic_shop/screens/home/home_screen.dart';
import 'package:electronic_shop/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:provider/provider.dart';
import '../provider/dark_theme_provider.dart';
import 'package:badges/badges.dart' as badges;

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  late PageController _pageController;
  int bottomNavBarMaxCount = 4;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  final List<Widget> _screens = [
    const HomeScreen(),
    const CategoriesScreen(),
    const CartScreen(),
    const SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      body: PersistentTabView(
        context,
        screens: _screens,
        items: _navBarItems(),
        confineInSafeArea: true,
        backgroundColor: themeState.getDarkTheme
            ? Theme.of(context).cardColor
            : Colors.white,
        handleAndroidBackButtonPress: true,
        resizeToAvoidBottomInset: true,
        stateManagement: true,
        hideNavigationBarWhenKeyboardShows: true,
        margin: const EdgeInsets.all(AppMargin.m0),
        popAllScreensOnTapOfSelectedTab: true,
        itemAnimationProperties: const ItemAnimationProperties(
          duration: Duration(milliseconds: AppConstants.bottomNavBarDuration),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: const ScreenTransitionAnimation(
          animateTabTransition: true,
          curve: Curves.ease,
          duration: Duration(milliseconds: AppConstants.bottomNavBarDuration),
        ),
        navBarStyle: NavBarStyle.style3, // Use style 3
      ),
    );
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(AppIcons.home),
        title: AppStrings.home,
        activeColorPrimary: Colors.cyan,
        inactiveColorPrimary: Colors.blueGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(AppIcons.categories),
        title: AppStrings.categories,
        activeColorPrimary: Colors.cyan,
        inactiveColorPrimary: Colors.blueGrey,
      ),
      PersistentBottomNavBarItem(
        // icon: const Icon(AppIcons.cart),
        icon: const badges.Badge(
          badgeContent: Text('3'),
          badgeAnimation: badges.BadgeAnimation.slide(
            animationDuration: Duration(seconds: 3),
            colorChangeAnimationDuration: Duration(seconds: 1),
            loopAnimation: true,
            curve: Curves.fastOutSlowIn,
            colorChangeAnimationCurve: Curves.easeInCubic,
          ),
          child: Icon(AppIcons.cart),
        ),
        title: AppStrings.cart,
        activeColorPrimary: Colors.cyan,
        inactiveColorPrimary: Colors.blueGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(AppIcons.settings),
        title: AppStrings.settings,
        activeColorPrimary: Colors.cyan,
        inactiveColorPrimary: Colors.blueGrey,
      ),
    ];
  }
}

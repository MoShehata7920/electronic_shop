import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:electronic_shop/resources/icons_manager.dart';
import 'package:electronic_shop/resources/strings_manager.dart';
import 'package:electronic_shop/resources/values_manager.dart';
import 'package:electronic_shop/screens/cart_screen.dart';
import 'package:electronic_shop/screens/categories_screen.dart';
import 'package:electronic_shop/screens/home_screen.dart';
import 'package:electronic_shop/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/dark_theme_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentIndex);
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
      body: PageView(
        controller: _pageController,
        children: _screens,
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      bottomNavigationBar: BottomNavyBar(
        backgroundColor: themeState.getDarkTheme
            ? Theme.of(context).cardColor
            : Colors.white,
        selectedIndex: currentIndex,
        showElevation: true,
        itemCornerRadius: 24,
        curve: Curves.easeIn,
        onItemSelected: (index) {
          setState(() {
            currentIndex = index;
            _pageController.animateToPage(index,
                duration: const Duration(
                    milliseconds: AppConstants.bottomNavBarDuration),
                curve: Curves.ease);
          });
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
            icon: const Icon(AppIcon.home),
            title: Text(AppStrings.home),
            activeColor: Colors.red,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(AppIcon.categories),
            title: Text(AppStrings.categories),
            activeColor: Colors.purpleAccent,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(AppIcon.cart),
            title: Text(
              AppStrings.cart,
            ),
            activeColor: Colors.pink,
            textAlign: TextAlign.center,
          ),
          BottomNavyBarItem(
            icon: const Icon(AppIcon.settings),
            title: Text(AppStrings.settings),
            activeColor: Colors.blue,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

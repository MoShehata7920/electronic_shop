import 'package:electronic_shop/resources/icons_manager.dart';
import 'package:electronic_shop/resources/strings_manager.dart';
import 'package:electronic_shop/screens/cart/cart_screen.dart';
import 'package:electronic_shop/screens/categories/categories_screen.dart';
import 'package:electronic_shop/screens/home/home_screen.dart';
import 'package:electronic_shop/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';
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

    return Scaffold(
      body: _screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: _navBarItems(),
        selectedItemColor: Colors.cyan,
        unselectedItemColor: Colors.blueGrey,
      ),
    );
  }

  List<BottomNavigationBarItem> _navBarItems() {
    final cartProvider = Provider.of<CartProvider>(context);
    final cartItemsList = cartProvider.getCartItems.values.toList();

    return [
      BottomNavigationBarItem(
        icon: const Icon(AppIcons.home),
        activeIcon: const Icon(AppIcons.boldHome),
        label: AppStrings.home,
      ),
      BottomNavigationBarItem(
        icon: const Icon(AppIcons.categories),
        activeIcon: const Icon(AppIcons.boldCategories),
        label: AppStrings.categories,
      ),
      BottomNavigationBarItem(
        icon: badges.Badge(
          badgeContent: Text('${cartItemsList.length}'),
          badgeAnimation: const badges.BadgeAnimation.slide(
            animationDuration: Duration(seconds: 3),
            colorChangeAnimationDuration: Duration(seconds: 1),
            loopAnimation: true,
            curve: Curves.fastOutSlowIn,
            colorChangeAnimationCurve: Curves.easeInCubic,
          ),
          child: const Icon(AppIcons.cart),
        ),
        activeIcon: const Icon(AppIcons.boldCart),
        label: AppStrings.cart,
      ),
      BottomNavigationBarItem(
        icon: const Icon(AppIcons.settings),
        activeIcon: const Icon(AppIcons.boldSettings),
        label: AppStrings.settings,
      ),
    ];
  }
}

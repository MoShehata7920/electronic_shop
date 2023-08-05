import 'package:admin_panel/resources/assets_manager.dart';
import 'package:admin_panel/resources/icons_manager.dart';
import 'package:admin_panel/resources/strings_manager.dart';
import 'package:admin_panel/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../providers/dark_theme_provider.dart';
import '../screens/main_screen.dart';
import '../services/utils.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    final theme = Utils(context).getTheme;
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Lottie.asset(
              JsonAssets.admin,
            ),
          ),
          DrawerListTile(
            title: AppStrings.main,
            icon: AppIcons.home,
            press: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const MainScreen(),
                ),
              );
            },
          ),
          DrawerListTile(
            title: AppStrings.viewAllProducts,
            icon: AppIcons.store,
            press: () {},
          ),
          DrawerListTile(
            title: AppStrings.viewAllOrders,
            icon: AppIcons.bag,
            press: () {},
          ),
          SwitchListTile(
              title: Text(AppStrings.theme),
              secondary: Icon(themeState.getDarkTheme
                  ? AppIcons.darkMode
                  : AppIcons.lightMode),
              value: theme,
              onChanged: (value) {
                setState(() {
                  themeState.setDarkTheme = value;
                });
              })
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.press,
    required this.icon,
  }) : super(key: key);

  final String title;
  final VoidCallback press;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    final textColor = Utils(context).textColor;

    return ListTile(
        onTap: press,
        horizontalTitleGap: 0.0,
        leading: Icon(
          icon,
          size: AppSize.s18,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: textColor,
          ),
        ));
  }
}

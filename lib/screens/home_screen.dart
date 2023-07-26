import 'package:electronic_shop/provider/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../resources/icons_manager.dart';
import '../resources/strings_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
        body: Center(
            child: SwitchListTile(
      title: Text(StringsManager.darkMode),
      secondary: Icon(themeState.getDarkTheme
          ? IconManager.darkMode
          : IconManager.lightMode),
      value: themeState.getDarkTheme,
      onChanged: (bool value) {
        setState(() {
          themeState.setDarkTheme = value;
        });
      },
    )));
  }
}

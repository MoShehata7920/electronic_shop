import 'package:electronic_shop/provider/dark_theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Utils {
  BuildContext context;
  Utils(this.context);

  bool get getTheme => Provider.of<DarkThemeProvider>(context).getDarkTheme;
  Color get textColor => getTheme ? Colors.white : Colors.black;

  Size get screenSize => MediaQuery.of(context).size;
}

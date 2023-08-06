import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'resources/routes_manager.dart';
import 'resources/theme_data.dart';
import 'controllers/menu_controller.dart';
import 'providers/dark_theme_provider.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePreference.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AppMenuController(),
        ),
        ChangeNotifierProvider(
          create: (_) {
            return themeChangeProvider;
          },
        ),
      ],
      child: Consumer<DarkThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Electronics',
            theme: Styles.themeData(themeProvider.getDarkTheme, context),
            onGenerateRoute: RouteGenerator.getRoute,
            initialRoute: Routes.dashBoardRoute,
            home: const MainScreen(),
          );
        },
      ),
    );
  }
}

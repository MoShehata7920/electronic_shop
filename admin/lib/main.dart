import 'package:admin_panel/firebase_options.dart';
import 'package:admin_panel/resources/strings_manager.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'resources/routes_manager.dart';
import 'resources/theme_data.dart';
import 'controllers/menu_controller.dart';
import 'providers/dark_theme_provider.dart';
import 'screens/main_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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

  final Future<FirebaseApp> _firebaseInitialization = Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _firebaseInitialization,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                backgroundColor: Color(0xFF00001a),
                body: Center(
                  child: CircularProgressIndicator(
                    color: Colors.cyan,
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            final logger = Logger();
            logger.e(snapshot.error);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                backgroundColor: const Color(0xFF00001a),
                body: Center(
                  child: Text(
                    AppStrings.errorOccurred,
                    style: const TextStyle(color: Colors.cyan),
                  ),
                ),
              ),
            );
          }
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
        });
  }
}

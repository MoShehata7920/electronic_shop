import 'package:electronic_shop/firebase_options.dart';
import 'package:electronic_shop/provider/dark_theme_provider.dart';
import 'package:electronic_shop/provider/order_provider.dart';
import 'package:electronic_shop/provider/recently_viewed_provider.dart';
import 'package:electronic_shop/provider/wishlist_provider.dart';
import 'package:electronic_shop/resources/strings_manager.dart';
import 'package:electronic_shop/resources/theme_data.dart';
import 'package:electronic_shop/screens/splash_screen/splash.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'provider/cart_provider.dart';
import 'provider/products_provider.dart';
import 'resources/routes_manager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
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
                create: (_) {
                  return themeChangeProvider;
                },
              ),
              ChangeNotifierProvider(
                create: (_) {
                  return ProductProvider();
                },
              ),
              ChangeNotifierProvider(
                create: (_) {
                  return CartProvider();
                },
              ),
              ChangeNotifierProvider(
                create: (_) {
                  return OrderProvider();
                },
              ),
              ChangeNotifierProvider(
                create: (_) {
                  return WishListProvider();
                },
              ),
              ChangeNotifierProvider(
                create: (_) {
                  return RecentlyViewedProductsProvider();
                },
              ),
            ],
            child: Consumer<DarkThemeProvider>(
                builder: (context, themeProvider, child) {
              return MaterialApp(
                theme: Styles.themeData(themeProvider.getDarkTheme, context),
                debugShowCheckedModeBanner: false,
                onGenerateRoute: RouteGenerator.getRoute,
                initialRoute: Routes.splash,
                home: const SplashScreen(),
              );
            }),
          );
        });
  }
}

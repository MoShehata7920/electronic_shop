// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:electronic_shop/provider/cart_provider.dart';
import 'package:electronic_shop/provider/order_provider.dart';
import 'package:electronic_shop/provider/products_provider.dart';
import 'package:electronic_shop/provider/wishlist_provider.dart';
import 'package:electronic_shop/resources/assets_manager.dart';
import 'package:electronic_shop/resources/firebase_constants.dart';
import 'package:electronic_shop/resources/routes_manager.dart';
import 'package:electronic_shop/resources/strings_manager.dart';
import 'package:electronic_shop/services/animation.dart';
import 'package:electronic_shop/services/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () async {
      final productsProvider =
          Provider.of<ProductProvider>(context, listen: false);
      final cartProvider = Provider.of<CartProvider>(context, listen: false);
      final wishListProvider =
          Provider.of<WishListProvider>(context, listen: false);
      final orderProvider = Provider.of<OrderProvider>(context, listen: false);

      final User? user = authInstance.currentUser;
      if (user == null) {
        await productsProvider.fetchProducts();
      } else {
        await productsProvider.fetchProducts();
        await cartProvider.fetchCartItems();
        await wishListProvider.fetchWishList();
        await orderProvider.fetchOrders();
      }

      Navigator.pushReplacementNamed(context, Routes.mainScreenRoute);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screenSize;

    return Scaffold(
        backgroundColor: const Color(0xFF00001a),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Image.asset(ImagesAssets.splashLogo).animateOnPageLoad(
                    msDelay: 150, dx: 0.0, dy: -200.0, showDelay: 900),
                Column(
                  children: [
                    SizedBox(
                      height: size.height * 0.35,
                    ),
                    Text(
                      AppStrings.developedBy,
                      style: const TextStyle(color: Colors.cyan),
                    ).animateOnPageLoad(
                        msDelay: 300, dx: 0.0, dy: 70.0, showDelay: 300),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      AppStrings.mohamedShehata,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ).animateOnPageLoad(
                        msDelay: 300, dx: 0.0, dy: 70.0, showDelay: 300),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

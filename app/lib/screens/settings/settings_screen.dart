// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronic_shop/provider/cart_provider.dart';
import 'package:electronic_shop/provider/dark_theme_provider.dart';
import 'package:electronic_shop/provider/wishlist_provider.dart';
import 'package:electronic_shop/resources/firebase_constants.dart';
import 'package:electronic_shop/resources/icons_manager.dart';
import 'package:electronic_shop/resources/routes_manager.dart';
import 'package:electronic_shop/resources/values_manager.dart';
import 'package:electronic_shop/services/global_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import '../../resources/assets_manager.dart';
import '../../resources/strings_manager.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _addressTextController = TextEditingController();

  String? _userName;
  String? _userEmail;

  final User? user = authInstance.currentUser;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  Future<void> getUserData() async {
    if (user == null) {
      return;
    }
    try {
      String uid = user!.uid;

      final DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      _userName = userDoc.get("name");
      _userEmail = userDoc.get("email");
      _addressTextController.text = userDoc.get("address");
    } catch (error) {
      GlobalMethods.errorDialog(title: '$error', context: context);
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    final themeState = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        toolbarHeight: AppSize.s85,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        flexibleSpace: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppPadding.p10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      AppStrings.hi,
                      style: const TextStyle(
                          color: Colors.cyan,
                          fontSize: AppSize.s27,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _userName ?? '',
                      style: const TextStyle(
                        fontSize: AppSize.s25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: AppSize.s3,
                ),
                Text(
                  _userEmail ?? '',
                  style: const TextStyle(
                      fontSize: AppSize.s18, fontWeight: FontWeight.w400),
                )
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: AppPadding.p15),
          child: Column(
            children: [
              _buttonWidget(
                  buttonTitle: AppStrings.address,
                  buttonSubTitle: _addressTextController.text,
                  buttonIcon: AppIcons.address,
                  buttonFunction: () async {
                    _showAddressDialog();
                  }),
              _buttonWidget(
                  buttonTitle: AppStrings.orders,
                  buttonIcon: AppIcons.orders,
                  buttonFunction: () {
                    Navigator.pushNamed(context, Routes.ordersScreenRoute);
                  }),
              _buttonWidget(
                  buttonTitle: AppStrings.wishList,
                  buttonIcon: AppIcons.wishes,
                  buttonFunction: () {
                    Navigator.pushNamed(context, Routes.wishListScreenRoute);
                  }),
              _buttonWidget(
                  buttonTitle: AppStrings.viewed,
                  buttonIcon: AppIcons.viewed,
                  buttonFunction: () {
                    Navigator.pushNamed(
                        context, Routes.recentlyViewedProductsScreenRoute);
                  }),
              _buttonWidget(
                  buttonTitle: AppStrings.resetPassword,
                  buttonIcon: AppIcons.unLock,
                  buttonFunction: () {}),
              _buttonWidget(
                  buttonTitle: AppStrings.language,
                  buttonIcon: AppIcons.language,
                  buttonFunction: () {}),
              SwitchListTile(
                title: Text(AppStrings.darkMode),
                secondary: Icon(themeState.getDarkTheme
                    ? AppIcons.darkMode
                    : AppIcons.lightMode),
                value: themeState.getDarkTheme,
                onChanged: (bool value) {
                  setState(() {
                    themeState.setDarkTheme = value;
                  });
                },
              ),
              _signOutButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonWidget(
      {required String buttonTitle,
      String? buttonSubTitle,
      required IconData buttonIcon,
      required Function buttonFunction}) {
    return ListTile(
      title: Text(
        buttonTitle,
        style: const TextStyle(fontSize: AppSize.s20),
      ),
      subtitle: Text(
        buttonSubTitle ?? "",
        style: const TextStyle(fontSize: AppSize.s12),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      leading: Icon(buttonIcon),
      trailing: const Icon(AppIcons.arrowRight),
      onTap: () {
        final User? user = authInstance.currentUser;
        if (user == null) {
          GlobalMethods.warningDialog(
            title: AppStrings.authError,
            subtitle: AppStrings.pleaseSignIn,
            function: () {
              buttonFunction();
            },
            warningIcon: JsonAssets.error,
            context: context,
            navigateTo: () {
              Navigator.pushReplacementNamed(context, Routes.loginScreenRoute);
            },
          );
          return;
        }
        buttonFunction();
      },
    );
  }

  Future<void> _showAddressDialog() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                SizedBox(
                    width: AppSize.s30,
                    height: AppSize.s30,
                    child: Lottie.asset(JsonAssets.address)),
                const SizedBox(
                  width: AppSize.s2,
                ),
                Text(AppStrings.updateAddress),
              ],
            ),
            content: TextField(
              controller: _addressTextController,
              onChanged: (value) {},
              maxLines: 2,
              decoration: InputDecoration(hintText: AppStrings.yourAddress),
            ),
            actions: [
              TextButton(
                  onPressed: () async {
                    String uid = user!.uid;
                    try {
                      await FirebaseFirestore.instance
                          .collection('users')
                          .doc(uid)
                          .update({'address': _addressTextController.text});
                      Navigator.pop(context);
                      setState(() {
                        _addressTextController.text;
                      });
                    } catch (error) {
                      GlobalMethods.errorDialog(
                          title: '$error', context: context);
                    }
                  },
                  child: Text(
                    AppStrings.update,
                    style: const TextStyle(
                        fontSize: AppSize.s16, color: Colors.cyan),
                  ))
            ],
          );
        });
  }

  Widget _signOutButtonWidget() {
    final User? user = authInstance.currentUser;

    return ListTile(
      title: Text(
        user == null ? AppStrings.login : AppStrings.logout,
        style: const TextStyle(fontSize: AppSize.s20),
      ),
      leading: user == null
          ? const Icon(AppIcons.logIn)
          : const Icon(AppIcons.logOut),
      trailing: const Icon(AppIcons.arrowRight),
      onTap: () {
        user == null
            ? Navigator.pushReplacementNamed(context, Routes.loginScreenRoute)
            : GlobalMethods.warningDialog(
                title: AppStrings.logout,
                subtitle: AppStrings.wantToLogOut,
                function: () {
                  authInstance.signOut();
                  final cartProvider =
                      Provider.of<CartProvider>(context, listen: false);
                  final wishListProvider =
                      Provider.of<WishListProvider>(context, listen: false);
                  cartProvider.clearCart();
                  wishListProvider.clearWishList();
                },
                warningIcon: JsonAssets.logout,
                context: context,
                navigateTo: () {
                  Navigator.pushReplacementNamed(
                      context, Routes.loginScreenRoute);
                },
              );
      },
    );
  }

  @override
  void dispose() {
    _addressTextController.dispose();
    super.dispose();
  }
}

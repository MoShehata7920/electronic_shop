import 'package:electronic_shop/provider/dark_theme_provider.dart';
import 'package:electronic_shop/resources/icons_manager.dart';
import 'package:electronic_shop/resources/values_manager.dart';
import 'package:electronic_shop/screens/settings/inner_settings_screens/recently_viewed/recently_viewed_screen.dart';
import 'package:electronic_shop/screens/settings/inner_settings_screens/wish_list/wish_list_screen.dart';
import 'package:electronic_shop/screens/settings/inner_settings_screens/your_orders/orders_screen.dart';
import 'package:electronic_shop/services/global_methods.dart';
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
                        AppStrings.myName,
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
                  const Text(
                    "test@test.com",
                    style: TextStyle(
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
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const OrdersScreen(),
                      ));
                    }),
                _buttonWidget(
                    buttonTitle: AppStrings.wishList,
                    buttonIcon: AppIcons.wishes,
                    buttonFunction: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const WishListScreen(),
                      ));
                    }),
                _buttonWidget(
                    buttonTitle: AppStrings.viewed,
                    buttonIcon: AppIcons.viewed,
                    buttonFunction: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const RecentlyViewedScreen(),
                      ));
                    }),
                _buttonWidget(
                    buttonTitle: AppStrings.forgotPassword,
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
                _buttonWidget(
                    buttonTitle: AppStrings.logout,
                    buttonIcon: AppIcons.logOut,
                    buttonFunction: () {
                      GlobalMethods.warningDialog(
                          title: AppStrings.logout,
                          subtitle: AppStrings.wantToLogOut,
                          function: () {},
                          warningIcon: JsonAssets.logout,
                          context: context);
                    }),
              ],
            ),
          ),
        ));
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
                  onPressed: () {},
                  child: Text(
                    AppStrings.update,
                    style: const TextStyle(
                        fontSize: AppSize.s16, color: Colors.cyan),
                  ))
            ],
          );
        });
  }

  @override
  void dispose() {
    _addressTextController.dispose();
    super.dispose();
  }
}

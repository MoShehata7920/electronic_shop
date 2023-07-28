import 'package:electronic_shop/provider/dark_theme_provider.dart';
import 'package:electronic_shop/resources/icons_manager.dart';
import 'package:electronic_shop/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../resources/strings_manager.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
                            fontSize: AppSize.s25, fontWeight: FontWeight.bold),
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
                    buttonSubTitle: "My Address2",
                    buttonIcon: AppIcons.address,
                    buttonFunction: () {}),
                _buttonWidget(
                    buttonTitle: AppStrings.orders,
                    buttonIcon: AppIcons.orders,
                    buttonFunction: () {}),
                _buttonWidget(
                    buttonTitle: AppStrings.wishList,
                    buttonIcon: AppIcons.wishes,
                    buttonFunction: () {}),
                _buttonWidget(
                    buttonTitle: AppStrings.viewed,
                    buttonIcon: AppIcons.viewed,
                    buttonFunction: () {}),
                _buttonWidget(
                    buttonTitle: AppStrings.forgotPassword,
                    buttonIcon: AppIcons.unLock,
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
                    buttonFunction: () {}),
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
        buttonFunction;
      },
    );
  }
}

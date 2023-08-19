import 'package:admin_panel/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';

class GlobalMethods {
  static Future<void> warningDialog({
    required String title,
    required String subtitle,
    // required Function function,
    required String warningIcon,
    required BuildContext context,
  }) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                SizedBox(
                    width: AppSize.s30,
                    height: AppSize.s30,
                    child: Lottie.asset(warningIcon)),
                const SizedBox(
                  width: AppSize.s2,
                ),
                Flexible(
                    child: Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
              ],
            ),
            content: Text(
              subtitle,
            ),
            actions: [
              // TextButton(
              //     onPressed: () {
              //       function();
              //     },
              //     child: Text(
              //       AppStrings.cancel,
              //       style: const TextStyle(
              //           color: Colors.cyan, fontSize: AppSize.s16),
              //     )),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    AppStrings.ok,
                    style: const TextStyle(
                        color: Colors.red, fontSize: AppSize.s16),
                  ))
            ],
          );
        });
  }

  static Future<void> errorDialog({
    required String title,
    required BuildContext context,
  }) async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(
              children: [
                SizedBox(
                    width: AppSize.s30,
                    height: AppSize.s30,
                    child: Lottie.asset(JsonAssets.error)),
                const SizedBox(
                  width: AppSize.s2,
                ),
                Flexible(
                    child: Text(
                  AppStrings.errorOccurred,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )),
              ],
            ),
            content: Text(
              title,
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    AppStrings.ok,
                    style: const TextStyle(
                        color: Colors.red, fontSize: AppSize.s16),
                  )),
            ],
          );
        });
  }

}

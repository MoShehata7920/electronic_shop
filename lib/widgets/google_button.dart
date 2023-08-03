import 'package:electronic_shop/resources/assets_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.cyan,
      child: InkWell(
        onTap: () {},
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            color: Colors.white,
            child: SizedBox(
                width: AppSize.s30,
                height: AppSize.s30,
                child: Lottie.asset(JsonAssets.google)),
          ),
          const SizedBox(
            width: AppSize.s8,
          ),
          Text(
            AppStrings.signInGoogle,
            style: const TextStyle(
                color: Colors.white,
                fontSize: AppSize.s18,
                fontWeight: FontWeight.normal),
          ),
        ]),
      ),
    );
  }
}

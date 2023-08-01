import 'package:electronic_shop/resources/assets_manager.dart';
import 'package:electronic_shop/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../resources/strings_manager.dart';
import '../../../services/utils.dart';

class EmptyOnSaleScreenWidget extends StatelessWidget {
  const EmptyOnSaleScreenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screenSize;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: LottieBuilder.asset(
                JsonAssets.empty,
                width: size.width * 0.59,
                height: size.height * 0.46,
                fit: BoxFit.fill,
              ),
            ),
            Text(
              AppStrings.emptyOnSaleScreen,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  fontSize: AppSize.s30, fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}

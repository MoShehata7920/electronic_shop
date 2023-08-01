import 'package:electronic_shop/resources/assets_manager.dart';
import 'package:electronic_shop/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../resources/strings_manager.dart';
import '../../services/utils.dart';

class EmptyCartWidget extends StatelessWidget {
  const EmptyCartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screenSize;

    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p5),
          child: Column(
            children: [
              LottieBuilder.asset(
                JsonAssets.emptyCart,
                width: size.width * 0.49,
                height: size.height * 0.36,
                fit: BoxFit.fill,
              ),
              Text(
                AppStrings.whoops,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.red,
                    fontSize: AppSize.s38,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: AppSize.s15,
              ),
              Text(
                AppStrings.emptyCart,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.cyan,
                    fontSize: AppSize.s20,
                    fontWeight: FontWeight.w200),
              ),
              const SizedBox(
                height: AppSize.s50,
              ),
              Material(
                color: Colors.cyan.withOpacity(0.3),
                borderRadius: BorderRadius.circular(AppSize.s12),
                child: InkWell(
                  borderRadius: BorderRadius.circular(AppSize.s12),
                  onTap: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p10),
                    child: Text(
                      AppStrings.shopNow,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: AppSize.s20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

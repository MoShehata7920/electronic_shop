import 'package:electronic_shop/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../services/utils.dart';

class EmptyScreenWidget extends StatelessWidget {
  const EmptyScreenWidget(
      {super.key,
      required this.emptyScreenAsset,
      required this.emptyScreenTitle,
      required this.emptyScreenSubTitle,
      required this.buttonText,
      required this.buttonFunction,
      required this.isThereButton});

  final String emptyScreenAsset,
      emptyScreenTitle,
      emptyScreenSubTitle,
      buttonText;
  final Function buttonFunction;
  final bool isThereButton;

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
                emptyScreenAsset,
                width: size.width * 0.49,
                height: size.height * 0.36,
                fit: BoxFit.fill,
              ),
              Text(
                emptyScreenTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.red,
                    fontSize: AppSize.s38,
                    fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: AppSize.s20,
              ),
              Text(
                emptyScreenSubTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: Colors.cyan,
                    fontSize: AppSize.s22,
                    fontWeight: FontWeight.w200),
              ),
              const SizedBox(
                height: AppSize.s50,
              ),
              isThereButton
                  ? Material(
                      color: Colors.cyan.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(AppSize.s12),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        onTap: () {
                          buttonFunction();
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(AppPadding.p10),
                          child: Text(
                            buttonText,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: AppSize.s20,
                            ),
                          ),
                        ),
                      ),
                    )
                  : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

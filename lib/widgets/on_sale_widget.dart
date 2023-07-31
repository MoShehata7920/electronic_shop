import 'package:electronic_shop/resources/icons_manager.dart';
import 'package:electronic_shop/resources/values_manager.dart';
import 'package:electronic_shop/widgets/heart_widget.dart';
import 'package:electronic_shop/widgets/price_widget.dart';
import 'package:electronic_shop/services/utils.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({super.key});

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}

class _OnSaleWidgetState extends State<OnSaleWidget> {
  @override
  Widget build(BuildContext context) {
    final Color textColor = Utils(context).textColor;
    Size size = Utils(context).screenSize;

    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: SizedBox(
        width: size.width * 0.41,
        child: Material(
          color: Theme.of(context).cardColor.withOpacity(0.9),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppSize.s12),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FancyShimmerImage(
                        imageUrl:
                            'https://th.bing.com/th/id/R.d88fba714d703a2dd63d86f2d155acb0?rik=%2f6lrY7GuFxHQLQ&riu=http%3a%2f%2fpluspng.com%2fimg-png%2ftv-hd-png-km0255uhd-0-png-km0255uhd-1-png-1200.png&ehk=KaPoTFpWXYJo7OmaUEsSkxB4eDIQDcPIYJArJ4AegBg%3d&risl=&pid=ImgRaw&r=0',
                        width: size.width * 0.28,
                        height: size.height * 0.15,
                        boxFit: BoxFit.fill,
                      ),
                      const SizedBox(
                        width: AppSize.s8,
                      ),
                      Column(
                        children: [
                          Column(
                            children: [
                              GestureDetector(
                                onTap: () {},
                                child: Icon(
                                  AppIcons.bag,
                                  size: AppSize.s18,
                                  color: textColor,
                                ),
                              ),
                              const SizedBox(
                                height: AppSize.s10,
                              ),
                              const HeartButton(),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  const PriceWidget(),
                  const SizedBox(
                    height: AppSize.s5,
                  ),
                  Expanded(
                    child: Text(
                      "Samsung smart TV",
                      style: TextStyle(
                          color: textColor,
                          fontSize: AppSize.s15,
                          fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

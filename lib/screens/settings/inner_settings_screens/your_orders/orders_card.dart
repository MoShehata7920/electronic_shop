import 'package:electronic_shop/resources/strings_manager.dart';
import 'package:electronic_shop/resources/values_manager.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import '../../../../services/utils.dart';

class OrdersCard extends StatefulWidget {
  const OrdersCard({super.key});

  @override
  State<OrdersCard> createState() => _OrdersCardState();
}

class _OrdersCardState extends State<OrdersCard> {
  final _quantityTextController = TextEditingController();

  @override
  void initState() {
    _quantityTextController.text = "1";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screenSize;
    double cardHeight = size.height * 0.13;

    return GestureDetector(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Flexible(
          child: SizedBox(
            height: cardHeight,
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(AppSize.s12)),
              child: Row(
                children: [
                  SizedBox(
                    height: cardHeight,
                    child: FancyShimmerImage(
                      imageUrl:
                          'https://th.bing.com/th/id/R.d88fba714d703a2dd63d86f2d155acb0?rik=%2f6lrY7GuFxHQLQ&riu=http%3a%2f%2fpluspng.com%2fimg-png%2ftv-hd-png-km0255uhd-0-png-km0255uhd-1-png-1200.png&ehk=KaPoTFpWXYJo7OmaUEsSkxB4eDIQDcPIYJArJ4AegBg%3d&risl=&pid=ImgRaw&r=0',
                      width: size.width * 0.25,
                      height: cardHeight,
                      boxFit: BoxFit.fill,
                    ),
                  ),
                  const SizedBox(
                    width: AppSize.s10,
                  ),
                  Flexible(
                    flex: 3,
                    child: SizedBox(
                      width: size.width * 0.45,
                      height: cardHeight,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Flexible(
                            child: Text(
                              "Samsung smart TV",
                              style: TextStyle(
                                  fontSize: AppSize.s16,
                                  fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          const SizedBox(
                            height: AppSize.s15,
                          ),
                          Flexible(
                            child: Text(
                              "${AppStrings.paid}\$11000.0",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: AppSize.s14),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Flexible(
                      flex: 2,
                      child: Text(
                        "02/08/2023",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }
}

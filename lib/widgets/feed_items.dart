import 'package:electronic_shop/resources/strings_manager.dart';
import 'package:electronic_shop/resources/values_manager.dart';
import 'package:electronic_shop/screens/inner_screens/product_screen/product_screen.dart';
import 'package:electronic_shop/widgets/heart_widget.dart';
import 'package:electronic_shop/widgets/price_widget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import '../services/utils.dart';

class FeedWidget extends StatefulWidget {
  const FeedWidget({super.key});

  @override
  State<FeedWidget> createState() => _FeedWidgetState();
}

class _FeedWidgetState extends State<FeedWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color textColor = Utils(context).textColor;
    Size size = Utils(context).screenSize;

    return Padding(
      padding: const EdgeInsets.all(AppPadding.p10),
      child: Material(
          borderRadius: BorderRadius.circular(AppSize.s12),
          color: Theme.of(context).cardColor,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ProductScreen(),
              ));
            },
            borderRadius: BorderRadius.circular(AppSize.s12),
            child: Column(
              children: [
                const SizedBox(
                  height: AppSize.s5,
                ),
                FancyShimmerImage(
                  imageUrl:
                      'https://th.bing.com/th/id/R.d88fba714d703a2dd63d86f2d155acb0?rik=%2f6lrY7GuFxHQLQ&riu=http%3a%2f%2fpluspng.com%2fimg-png%2ftv-hd-png-km0255uhd-0-png-km0255uhd-1-png-1200.png&ehk=KaPoTFpWXYJo7OmaUEsSkxB4eDIQDcPIYJArJ4AegBg%3d&risl=&pid=ImgRaw&r=0',
                  width: size.width * 0.2,
                  height: size.height * 0.121,
                  boxFit: BoxFit.fill,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: AppPadding.p5, horizontal: AppPadding.p10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          "Title",
                          style: TextStyle(
                              color: textColor,
                              fontSize: AppSize.s18,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      const HeartButton(),
                    ],
                  ),
                ),
                const PriceWidget(
                  salePrice: 0,
                  price: 12000.0,
                  isProductsOnSale: false,
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {},
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Theme.of(context).cardColor),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                        bottomLeft:
                                            Radius.circular(AppSize.s12),
                                        bottomRight:
                                            Radius.circular(AppSize.s12))))),
                    child: Text(
                      AppStrings.addToCart,
                      maxLines: 1,
                      style: TextStyle(color: textColor, fontSize: AppSize.s18),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

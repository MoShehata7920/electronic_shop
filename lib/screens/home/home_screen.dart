import 'package:electronic_shop/resources/icons_manager.dart';
import 'package:electronic_shop/resources/strings_manager.dart';
import 'package:electronic_shop/resources/values_manager.dart';
import 'package:electronic_shop/widgets/feed_items.dart';
import 'package:electronic_shop/widgets/on_sale_widget.dart';
import 'package:electronic_shop/services/utils.dart';
import 'package:flutter/material.dart';
import '../../widgets/carousel_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screenSize;

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: size.height * 0.33, child: const SwiperWidget()),
          const SizedBox(
            height: AppSize.s5,
          ),
          TextButton(
              onPressed: () {},
              child: Text(
                AppStrings.viewAll,
                style:
                    const TextStyle(fontSize: AppSize.s18, color: Colors.cyan),
              )),
          Row(
            children: [
              RotatedBox(
                quarterTurns: -1,
                child: Row(
                  children: [
                    Text(
                      AppStrings.onSale.toUpperCase(),
                      style: const TextStyle(
                          color: Colors.red,
                          fontSize: AppSize.s18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: AppSize.s5,
                    ),
                    const Icon(
                      AppIcons.discount,
                      color: Colors.red,
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: AppSize.s8,
              ),
              Flexible(
                child: SizedBox(
                  height: size.height * 0.28,
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return const OnSaleWidget();
                    },
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(AppPadding.p8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.ourProducts,
                  style: const TextStyle(fontSize: AppSize.s18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      AppStrings.browseAll,
                      style: const TextStyle(fontSize: AppSize.s18, color: Colors.cyan),
                    )),
              ],
            ),
          ),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            childAspectRatio: size.width / (size.height * 0.61),
            children: List.generate(4, (index) {
              return const FeedWidget();
            }),
          )
        ],
      ),
    ));
  }
}

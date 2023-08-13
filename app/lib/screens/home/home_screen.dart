import 'package:electronic_shop/resources/assets_manager.dart';
import 'package:electronic_shop/resources/icons_manager.dart';
import 'package:electronic_shop/resources/strings_manager.dart';
import 'package:electronic_shop/resources/values_manager.dart';
import 'package:electronic_shop/screens/home/feeds_screen/feeds_screen.dart';
import 'package:electronic_shop/screens/home/on_sale_products_screen/on_sale_products_screen.dart';
import 'package:electronic_shop/widgets/feed_items.dart';
import 'package:electronic_shop/widgets/on_sale_widget.dart';
import 'package:electronic_shop/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/products_model.dart';
import '../../provider/products_provider.dart';
import '../../widgets/carousel_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<String> carouselImages = [
    ImagesAssets.c1,
    ImagesAssets.c2,
    ImagesAssets.c3,
    ImagesAssets.c4,
    ImagesAssets.c5,
    ImagesAssets.c6,
    ImagesAssets.c7,
    ImagesAssets.c8,
  ];

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screenSize;

    final productProvider = Provider.of<ProductProvider>(context);
    List<ProductModel> allProducts = productProvider.getProducts;
    List<ProductModel> onSaleProducts = productProvider.getOnSaleProducts;

    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
              height: size.height * 0.33,
              child: SwiperWidget(
                carouselImages: carouselImages,
                isSwiperPaginationActive: true,
              )),
          const SizedBox(
            height: AppSize.s5,
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const OnSaleProductsScreen(),
                ));
              },
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
                      return ChangeNotifierProvider.value(
                          value: onSaleProducts[index],
                          child: const OnSaleWidget());
                    },
                    itemCount:
                        onSaleProducts.length < 10 ? onSaleProducts.length : 10,
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
                  style: const TextStyle(
                      fontSize: AppSize.s18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const FeedsScreen(),
                      ));
                    },
                    child: Text(
                      AppStrings.browseAll,
                      style: const TextStyle(
                          fontSize: AppSize.s18, color: Colors.cyan),
                    )),
              ],
            ),
          ),
          GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            padding: EdgeInsets.zero,
            childAspectRatio: size.width / (size.height * 0.61),
            children: List.generate(
                allProducts.length < 4 ? allProducts.length : 4, (index) {
              return ChangeNotifierProvider.value(
                  value: allProducts[index], child: const FeedWidget());
            }),
          )
        ],
      ),
    ));
  }
}

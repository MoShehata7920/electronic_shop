// ignore_for_file: unnecessary_null_comparison

import 'package:electronic_shop/provider/cart_provider.dart';
import 'package:electronic_shop/provider/recently_viewed_provider.dart';
import 'package:electronic_shop/resources/assets_manager.dart';
import 'package:electronic_shop/resources/firebase_constants.dart';
import 'package:electronic_shop/resources/routes_manager.dart';
import 'package:electronic_shop/resources/strings_manager.dart';
import 'package:electronic_shop/resources/values_manager.dart';
import 'package:electronic_shop/services/global_methods.dart';
import 'package:electronic_shop/widgets/heart_widget.dart';
import 'package:electronic_shop/widgets/price_widget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/products_model.dart';
import '../provider/wishlist_provider.dart';
import '../services/utils.dart';

class FeedWidget extends StatefulWidget {
  const FeedWidget({
    super.key,
  });

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

    final productModel = Provider.of<ProductModel>(context);

    final cartProvider = Provider.of<CartProvider>(context);

    final recentlyViewedProductsProvider =
        Provider.of<RecentlyViewedProductsProvider>(context);

    bool? isInCart =
        cartProvider.getCartItems.containsKey(productModel.productId);

    final wishListProvider = Provider.of<WishListProvider>(context);
    bool? isInWishedList =
        wishListProvider.getWishedItems.containsKey(productModel.productId);

    return Padding(
      padding: const EdgeInsets.all(AppPadding.p10),
      child: Material(
          borderRadius: BorderRadius.circular(AppSize.s12),
          color: Theme.of(context).cardColor,
          child: InkWell(
            onTap: () {
              recentlyViewedProductsProvider
                  .addProductToRecentlyViewedList(productModel.productId);
              Navigator.pushNamed(context, Routes.productScreenRoute,
                  arguments: productModel.productId);
            },
            borderRadius: BorderRadius.circular(AppSize.s12),
            child: Column(
              children: [
                const SizedBox(
                  height: AppSize.s5,
                ),
                FancyShimmerImage(
                  imageUrl: productModel.productImage,
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
                          productModel.productName,
                          style: TextStyle(
                              color: textColor,
                              fontSize: AppSize.s18,
                              fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      HeartButton(
                        productId: productModel.productId,
                        isInWishList: isInWishedList,
                      ),
                    ],
                  ),
                ),
                PriceWidget(
                  salePrice: productModel.productSalePrice,
                  price: productModel.productPrice,
                  isProductsOnSale: productModel.isProductOnSale,
                ),
                const Spacer(),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: isInCart
                        ? null
                        : () async {
                            final User? user = authInstance.currentUser;
                            if (user == null) {
                              GlobalMethods.warningDialog(
                                title: AppStrings.authError,
                                subtitle: AppStrings.pleaseSignIn,
                                function: () {},
                                warningIcon: JsonAssets.error,
                                context: context,
                                navigateTo: () {
                                  Navigator.pushReplacementNamed(
                                      context, Routes.loginScreenRoute);
                                },
                              );
                              return;
                            }
                            await cartProvider.addToCart(
                                productId: productModel.productId,
                                quantity: 1,
                                context: context);
                            if (user != null) {
                              await cartProvider.fetchCartItems();
                              await wishListProvider.fetchWishList();
                            }
                          },
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
                      isInCart ? AppStrings.inCart : AppStrings.addToCart,
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

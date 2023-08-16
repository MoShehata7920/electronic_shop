import 'package:electronic_shop/models/products_model.dart';
import 'package:electronic_shop/provider/recently_viewed_provider.dart';
import 'package:electronic_shop/resources/assets_manager.dart';
import 'package:electronic_shop/resources/firebase_constants.dart';
import 'package:electronic_shop/resources/icons_manager.dart';
import 'package:electronic_shop/resources/routes_manager.dart';
import 'package:electronic_shop/resources/strings_manager.dart';
import 'package:electronic_shop/resources/values_manager.dart';
import 'package:electronic_shop/services/global_methods.dart';
import 'package:electronic_shop/widgets/heart_widget.dart';
import 'package:electronic_shop/widgets/price_widget.dart';
import 'package:electronic_shop/services/utils.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/cart_provider.dart';
import '../provider/wishlist_provider.dart';

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
      padding: const EdgeInsets.all(AppPadding.p8),
      child: SizedBox(
        width: size.width * 0.41,
        child: Material(
          color: Theme.of(context).cardColor.withOpacity(0.9),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppSize.s12),
            onTap: () {
              recentlyViewedProductsProvider
                  .addProductToRecentlyViewedList(productModel.productId);
              Navigator.pushNamed(context, Routes.productScreenRoute,
                  arguments: productModel.productId);
            },
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
                        imageUrl: productModel.productImage,
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
                                onTap: isInCart
                                    ? null
                                    : () {
                                        final User? user =
                                            authInstance.currentUser;
                                        if (user == null) {
                                          GlobalMethods.warningDialog(
                                            title: AppStrings.authError,
                                            subtitle: AppStrings.pleaseSignIn,
                                            function: () {},
                                            warningIcon: JsonAssets.error,
                                            context: context,
                                            navigateTo: () {
                                              Navigator.pushReplacementNamed(
                                                  context,
                                                  Routes.loginScreenRoute);
                                            },
                                          );
                                          return;
                                        }
                                        cartProvider.addProductsToCart(
                                            productId: productModel.productId,
                                            quantity: 1);
                                      },
                                child: Icon(
                                  isInCart ? AppIcons.boldBag : AppIcons.bag,
                                  size: AppSize.s18,
                                  color: isInCart ? Colors.green : textColor,
                                ),
                              ),
                              const SizedBox(
                                height: AppSize.s20,
                              ),
                              HeartButton(
                                productId: productModel.productId,
                                isInWishList: isInWishedList,
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                  PriceWidget(
                    salePrice: productModel.productSalePrice,
                    price: productModel.productPrice,
                    isProductsOnSale: productModel.isProductOnSale,
                  ),
                  const SizedBox(
                    height: AppSize.s5,
                  ),
                  Flexible(
                    child: Text(
                      productModel.productName,
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

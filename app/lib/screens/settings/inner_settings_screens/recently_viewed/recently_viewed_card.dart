import 'package:electronic_shop/models/recently_viewed_model.dart';
import 'package:electronic_shop/provider/cart_provider.dart';
import 'package:electronic_shop/provider/products_provider.dart';
import 'package:electronic_shop/provider/wishlist_provider.dart';
import 'package:electronic_shop/resources/firebase_constants.dart';
import 'package:electronic_shop/resources/icons_manager.dart';
import 'package:electronic_shop/resources/routes_manager.dart';
import 'package:electronic_shop/resources/strings_manager.dart';
import 'package:electronic_shop/resources/values_manager.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../services/utils.dart';

class RecentlyViewedCard extends StatefulWidget {
  const RecentlyViewedCard({super.key});

  @override
  State<RecentlyViewedCard> createState() => _RecentlyViewedCardState();
}

class _RecentlyViewedCardState extends State<RecentlyViewedCard> {
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

    final productProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final wishListProvider = Provider.of<WishListProvider>(context);

    final recentlyViewedProductsModel =
        Provider.of<RecentlyViewedProductsModel>(context);

    final getCurrentProduct =
        productProvider.findProductById(recentlyViewedProductsModel.productId);

    double usedPrice = getCurrentProduct.isProductOnSale
        ? getCurrentProduct.productSalePrice
        : getCurrentProduct.productPrice;

    bool? isInCart =
        cartProvider.getCartItems.containsKey(getCurrentProduct.productId);

    final User? user = authInstance.currentUser;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.productScreenRoute,
            arguments: getCurrentProduct.productId);
      },
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
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
                    imageUrl: getCurrentProduct.productImage,
                    width: size.width * 0.25,
                    height: cardHeight,
                    boxFit: BoxFit.fill,
                  ),
                ),
                const SizedBox(
                  width: AppSize.s10,
                ),
                Flexible(
                  flex: 2,
                  child: SizedBox(
                    width: size.width * 0.45,
                    height: cardHeight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 2,
                          child: Text(
                            getCurrentProduct.productName,
                            style: const TextStyle(
                                fontSize: AppSize.s16,
                                fontWeight: FontWeight.bold),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        const Spacer(),
                        Flexible(
                          child: Text(
                            AppStrings.price + usedPrice.toString(),
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
                Flexible(
                    flex: 1,
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: AppPadding.p5),
                      child: isInCart
                          ? null
                          : Material(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(AppSize.s12),
                              child: Padding(
                                padding: const EdgeInsets.all(AppPadding.p5),
                                child: InkWell(
                                  onTap: () async {
                                    await cartProvider.addToCart(
                                        productId: getCurrentProduct.productId,
                                        quantity: 1,
                                        context: context);

                                    if (user != null) {
                                      await cartProvider.fetchCartItems();
                                      await wishListProvider.fetchWishList();
                                    }
                                  },
                                  child: const Icon(
                                    AppIcons.add,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                    ))
              ],
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

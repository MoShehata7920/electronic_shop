import 'package:electronic_shop/models/wishlist_model.dart';
import 'package:electronic_shop/provider/cart_provider.dart';
import 'package:electronic_shop/provider/products_provider.dart';
import 'package:electronic_shop/provider/wishlist_provider.dart';
import 'package:electronic_shop/resources/icons_manager.dart';
import 'package:electronic_shop/resources/routes_manager.dart';
import 'package:electronic_shop/resources/values_manager.dart';
import 'package:electronic_shop/widgets/heart_widget.dart';
import 'package:electronic_shop/services/utils.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class WishedProductCard extends StatefulWidget {
  const WishedProductCard({super.key});

  @override
  State<WishedProductCard> createState() => _WishedProductCardState();
}

class _WishedProductCardState extends State<WishedProductCard> {
  @override
  Widget build(BuildContext context) {
    final Color textColor = Utils(context).textColor;
    Size size = Utils(context).screenSize;

    final productProvider = Provider.of<ProductProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    final wishListProvider = Provider.of<WishListProvider>(context);
    final wishListModel = Provider.of<WishListModel>(context);

    final getCurrentProduct =
        productProvider.findProductById(wishListModel.productId);

    bool? isInWishedList =
        wishListProvider.getWishedItems.containsKey(wishListModel.productId);

    bool? isInCart =
        cartProvider.getCartItems.containsKey(getCurrentProduct.productId);

    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: SizedBox(
        width: size.width * 0.41,
        child: Material(
          color: Theme.of(context).cardColor.withOpacity(0.9),
          child: InkWell(
            borderRadius: BorderRadius.circular(AppSize.s12),
            onTap: () {
              Navigator.pushNamed(context, Routes.productScreenRoute,
                  arguments: wishListModel.productId);
            },
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: Column(
                children: [
                  FancyShimmerImage(
                    imageUrl: getCurrentProduct.productImage,
                    width: size.width * 0.3,
                    height: size.height * 0.15,
                    boxFit: BoxFit.fill,
                  ),
                  const SizedBox(
                    height: AppSize.s8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: isInCart
                            ? null
                            : () async {
                                await cartProvider.addToCart(
                                    productId: getCurrentProduct.productId,
                                    quantity: 1,
                                    context: context);
                                await cartProvider.fetchCartItems();
                              },
                        child: Icon(
                          isInCart ? AppIcons.boldBag : AppIcons.bag,
                          size: AppSize.s18,
                          color: isInCart ? Colors.green : textColor,
                        ),
                      ),
                      const SizedBox(
                        width: AppSize.s20,
                      ),
                      HeartButton(
                        productId: wishListModel.productId,
                        isInWishList: isInWishedList,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSize.s8,
                  ),
                  Flexible(
                    child: Center(
                      child: Text(
                        getCurrentProduct.productName,
                        style: TextStyle(
                            color: textColor,
                            fontSize: AppSize.s15,
                            fontWeight: FontWeight.bold),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
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

import 'package:electronic_shop/provider/products_provider.dart';
import 'package:electronic_shop/provider/wishlist_provider.dart';
import 'package:electronic_shop/resources/assets_manager.dart';
import 'package:electronic_shop/resources/firebase_constants.dart';
import 'package:electronic_shop/resources/icons_manager.dart';
import 'package:electronic_shop/resources/routes_manager.dart';
import 'package:electronic_shop/resources/strings_manager.dart';
import 'package:electronic_shop/resources/values_manager.dart';
import 'package:electronic_shop/services/global_methods.dart';
import 'package:electronic_shop/services/utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeartButton extends StatefulWidget {
  final String productId;
  final bool? isInWishList;
  const HeartButton(
      {super.key, required this.productId, this.isInWishList = false});

  @override
  State<HeartButton> createState() => _HeartButtonState();
}

class _HeartButtonState extends State<HeartButton> {
  @override
  Widget build(BuildContext context) {
    final Color textColor = Utils(context).textColor;

    final wishListProvider = Provider.of<WishListProvider>(context);

    final productProvider = Provider.of<ProductProvider>(context);
    final getCurrentProduct = productProvider.findProductById(widget.productId);

    return GestureDetector(
      onTap: () async {
        final User? user = authInstance.currentUser;
        if (user == null) {
          GlobalMethods.warningDialog(
            title: AppStrings.authError,
            subtitle: AppStrings.pleaseSignIn,
            function: () {},
            warningIcon: JsonAssets.error,
            context: context,
            navigateTo: () {
              Navigator.pushReplacementNamed(context, Routes.loginScreenRoute);
            },
          );
          return;
        }
        if (widget.isInWishList == false && widget.isInWishList != null) {
          await wishListProvider.addProductToWished(
              productId: widget.productId, context: context);
        } else {
          await wishListProvider.removeProductFromWishList(
              theWishId: wishListProvider
                  .getWishedItems[getCurrentProduct.productId]!.id,
              productId: widget.productId);
        }
        await wishListProvider.fetchWishList();
      },
      child: Icon(
        widget.isInWishList != null && widget.isInWishList == true
            ? AppIcons.boldHeart
            : AppIcons.heart,
        size: AppSize.s18,
        color: widget.isInWishList != null && widget.isInWishList == true
            ? Colors.red
            : textColor,
      ),
    );
  }
}

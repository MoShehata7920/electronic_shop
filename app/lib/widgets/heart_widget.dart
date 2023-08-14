import 'package:electronic_shop/provider/wishlist_provider.dart';
import 'package:electronic_shop/resources/icons_manager.dart';
import 'package:electronic_shop/resources/values_manager.dart';
import 'package:electronic_shop/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeartButton extends StatelessWidget {
  final String productId;
  final bool? isInWishList;
  const HeartButton(
      {super.key, required this.productId, this.isInWishList = false});

  @override
  Widget build(BuildContext context) {
    final Color textColor = Utils(context).textColor;

    final wishListProvider = Provider.of<WishListProvider>(context);

    return GestureDetector(
      onTap: () {
        wishListProvider.addRemoveProductWished(productId);
      },
      child: Icon(
        isInWishList != null && isInWishList == true
            ? AppIcons.boldHeart
            : AppIcons.heart,
        size: AppSize.s18,
        color: isInWishList != null && isInWishList == true
            ? Colors.red
            : textColor,
      ),
    );
  }
}

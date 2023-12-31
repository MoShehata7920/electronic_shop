import 'package:electronic_shop/resources/routes_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../provider/wishlist_provider.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/icons_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../../../../resources/values_manager.dart';
import '../../../../services/global_methods.dart';
import '../../../../services/utils.dart';
import '../../../../widgets/empty_screen.dart';
import 'wish_list_widget.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  WishListScreenState createState() => WishListScreenState();
}

class WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    final Color textColor = Utils(context).textColor;
    Size size = Utils(context).screenSize;

    final wishListProvider = Provider.of<WishListProvider>(context);
    final wishedProductsList =
        wishListProvider.getWishedItems.values.toList().reversed.toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppStrings.wishList,
          style: TextStyle(
            color: textColor,
            fontSize: AppSize.s22,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              GlobalMethods.warningDialog(
                title: AppStrings.emptyYourWishList,
                subtitle: AppStrings.areYouSure,
                function: () {
                  wishListProvider.clearWholeWishList();
                },
                warningIcon: JsonAssets.delete,
                context: context,
              );
            },
            icon: Icon(
              AppIcons.delete,
              color: textColor,
            ),
          ),
        ],
      ),
      body: wishedProductsList.isEmpty
          ? EmptyScreenWidget(
              emptyScreenAsset: JsonAssets.emptyWishList,
              emptyScreenTitle: AppStrings.noWishes,
              emptyScreenSubTitle: AppStrings.emptyWishList,
              buttonText: AppStrings.shopNow,
              buttonFunction: () {
                Navigator.pushNamed(context, Routes.mainScreenRoute);
              },
              isThereButton: true,
            )
          : GridView.count(
              shrinkWrap: true,
              crossAxisCount: 2,
              padding: EdgeInsets.zero,
              childAspectRatio: size.width / (size.height * 0.52),
              children: List.generate(wishedProductsList.length, (index) {
                return ChangeNotifierProvider.value(
                  value: wishedProductsList[index],
                  child: const WishedProductCard(),
                );
              }),
            ),
    );
  }
}

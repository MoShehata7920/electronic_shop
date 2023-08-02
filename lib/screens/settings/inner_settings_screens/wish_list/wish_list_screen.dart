import 'package:electronic_shop/widgets/back_arrow_button.dart';
import 'package:electronic_shop/widgets/feed_items.dart';
import 'package:flutter/material.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/icons_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../../../../resources/values_manager.dart';
import '../../../../services/global_methods.dart';
import '../../../../services/utils.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  Widget build(BuildContext context) {
    final Color textColor = Utils(context).textColor;
    Size size = Utils(context).screenSize;

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
              fontWeight: FontWeight.bold),
        ),
        leading: const BackArrowButton(),
        actions: [
          IconButton(
              onPressed: () {
                GlobalMethods.warningDialog(
                    title: AppStrings.emptyYourWishList,
                    subtitle: AppStrings.areYouSure,
                    function: () {},
                    warningIcon: JsonAssets.delete,
                    context: context);
              },
              icon: Icon(
                AppIcons.delete,
                color: textColor,
              )),
        ],
      ),
      body: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        padding: EdgeInsets.zero,
        childAspectRatio: size.width / (size.height * 0.56),
        children: List.generate(15, (index) {
          return const FeedWidget();
        }),
      ),
    );
  }
}

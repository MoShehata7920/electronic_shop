import 'package:electronic_shop/resources/assets_manager.dart';
import 'package:electronic_shop/screens/home/feeds_screen/feeds_screen.dart';
import 'package:electronic_shop/widgets/empty_screen.dart';
import 'package:flutter/material.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import '../../services/utils.dart';

class EmptyCartScreen extends StatelessWidget {
  const EmptyCartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Color textColor = Utils(context).textColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppStrings.cart,
          style: TextStyle(
            color: textColor,
            fontSize: AppSize.s24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: EmptyScreenWidget(
          emptyScreenAsset: JsonAssets.emptyCart,
          emptyScreenTitle: AppStrings.whoops,
          emptyScreenSubTitle: AppStrings.emptyCart,
          buttonText: AppStrings.shopNow,
          buttonFunction: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => const FeedsScreen(),
            ));
          }),
    );
  }
}

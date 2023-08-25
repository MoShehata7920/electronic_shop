import 'package:electronic_shop/provider/recently_viewed_provider.dart';
import 'package:electronic_shop/resources/routes_manager.dart';
import 'package:electronic_shop/screens/settings/inner_settings_screens/recently_viewed/recently_viewed_card.dart';
import 'package:electronic_shop/widgets/empty_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../resources/assets_manager.dart';
import '../../../../resources/icons_manager.dart';
import '../../../../resources/strings_manager.dart';
import '../../../../resources/values_manager.dart';
import '../../../../services/global_methods.dart';
import '../../../../services/utils.dart';
import '../../../../widgets/back_arrow_button.dart';

class RecentlyViewedScreen extends StatefulWidget {
  const RecentlyViewedScreen({super.key});

  @override
  State<RecentlyViewedScreen> createState() => _RecentlyViewedScreenState();
}

class _RecentlyViewedScreenState extends State<RecentlyViewedScreen> {
  @override
  Widget build(BuildContext context) {
    final Color textColor = Utils(context).textColor;

    final recentlyViewedProductsProvider =
        Provider.of<RecentlyViewedProductsProvider>(context);
    final recentlyViewedProductsList = recentlyViewedProductsProvider
        .getRecentlyViewedItems.values
        .toList()
        .reversed
        .toList();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            AppStrings.recentlyViewed,
            style: TextStyle(
              color: textColor,
              fontSize: AppSize.s24,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: const BackArrowButton(),
          actions: [
            IconButton(
                onPressed: () {
                  GlobalMethods.warningDialog(
                      title: AppStrings.emptyYourViewedList,
                      subtitle: AppStrings.areYouSure,
                      function: () {
                        recentlyViewedProductsProvider
                            .clearRecentlyViewedProductsList();
                      },
                      warningIcon: JsonAssets.delete,
                      context: context);
                },
                icon: Icon(
                  AppIcons.delete,
                  color: textColor,
                )),
          ],
        ),
        body: recentlyViewedProductsList.isEmpty
            ? EmptyScreenWidget(
                emptyScreenAsset: JsonAssets.emptyViewedScreen,
                emptyScreenTitle: AppStrings.noViewed,
                emptyScreenSubTitle: AppStrings.emptyViewedList,
                buttonText: AppStrings.shopNow,
                buttonFunction: () {
                  Navigator.pushNamed(
                    context,
                    Routes.mainScreenRoute,
                  );
                },
                isThereButton: true,
              )
            : ListView.builder(
                itemCount: recentlyViewedProductsList.length,
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                      value: recentlyViewedProductsList[index],
                      child: const RecentlyViewedCard());
                }));
  }
}

import 'package:electronic_shop/screens/settings/inner_settings_screens/recently_viewed/recently_viewed_card.dart';
import 'package:flutter/material.dart';
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
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const RecentlyViewedCard();
                  }),
            ),
          ],
        ));
  }
}

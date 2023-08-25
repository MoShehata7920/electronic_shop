import 'package:electronic_shop/provider/order_provider.dart';
import 'package:electronic_shop/resources/assets_manager.dart';
import 'package:electronic_shop/resources/routes_manager.dart';
import 'package:electronic_shop/screens/settings/inner_settings_screens/your_orders/orders_card.dart';
import 'package:electronic_shop/widgets/empty_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../resources/strings_manager.dart';
import '../../../../resources/values_manager.dart';
import '../../../../services/utils.dart';
import '../../../../widgets/back_arrow_button.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  Widget build(BuildContext context) {
    final Color textColor = Utils(context).textColor;

    final orderListProvider = Provider.of<OrderProvider>(context);
    final orderedProductsList = orderListProvider.getOrders.reversed.toList();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            AppStrings.yourOrders,
            style: TextStyle(
              color: textColor,
              fontSize: AppSize.s24,
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: const BackArrowButton(),
        ),
        body: orderedProductsList.isEmpty
            ? EmptyScreenWidget(
                emptyScreenAsset: JsonAssets.empty,
                emptyScreenTitle: AppStrings.noOrders,
                emptyScreenSubTitle: AppStrings.emptyOrdersList,
                buttonText: AppStrings.shopNow,
                buttonFunction: () {
                  Navigator.pushNamed(context, Routes.mainScreenRoute);
                },
                isThereButton: true,
              )
            : ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: orderedProductsList.length,
                itemBuilder: (context, index) {
                  return ChangeNotifierProvider.value(
                    value: orderedProductsList[index],
                    child: const OrdersCard(),
                  );
                }));
  }
}

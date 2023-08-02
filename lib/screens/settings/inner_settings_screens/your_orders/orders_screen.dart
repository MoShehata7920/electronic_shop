import 'package:electronic_shop/screens/settings/inner_settings_screens/your_orders/orders_card.dart';
import 'package:flutter/material.dart';
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
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const OrdersCard();
                  }),
            ),
          ],
        ));
  }
}

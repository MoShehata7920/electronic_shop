import 'package:flutter/material.dart';
import '../../resources/assets_manager.dart';
import '../../resources/icons_manager.dart';
import '../../resources/strings_manager.dart';
import '../../resources/values_manager.dart';
import '../../services/global_methods.dart';
import '../../services/utils.dart';
import 'cart_card_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final Color textColor = Utils(context).textColor;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          title: Text(
            AppStrings.cart,
            style: TextStyle(
              color: textColor,
              fontSize: AppSize.s24,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  GlobalMethods.warningDialog(
                      title: AppStrings.emptyYourCart,
                      subtitle: AppStrings.areYouSure,
                      function: () {},
                      warningIcon: JsonAssets.delete,
                      context: context);
                },
                icon: Icon(
                  AppIcons.delete,
                  color: textColor,
                  size: AppSize.s24,
                ))
          ],
        ),
        body: Column(
          children: [
            _checkOut(),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const CartCardWidget();
                  }),
            ),
          ],
        ));
  }

  Widget _checkOut() {
    Size size = Utils(context).screenSize;

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.1,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Material(
              color: Colors.green,
              borderRadius: BorderRadius.circular(AppSize.s12),
              child: InkWell(
                borderRadius: BorderRadius.circular(AppSize.s12),
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(AppPadding.p10),
                  child: Text(
                    AppStrings.orderNow,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: AppSize.s20,
                    ),
                  ),
                ),
              ),
            ),
            Text(
              "${AppStrings.total}\$35000",
              style: const TextStyle(
                  fontSize: AppSize.s20, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

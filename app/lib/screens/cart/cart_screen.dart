import 'package:electronic_shop/screens/home/home_screen.dart';
import 'package:electronic_shop/widgets/empty_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/cart_provider.dart';
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

    final cartProvider = Provider.of<CartProvider>(context);
    final cartItemsList =
        cartProvider.getCartItems.values.toList().reversed.toList();

    return cartItemsList.isEmpty
        ? EmptyScreenWidget(
            emptyScreenAsset: JsonAssets.emptyCart,
            emptyScreenTitle: AppStrings.whoops,
            emptyScreenSubTitle: AppStrings.emptyCart,
            buttonText: AppStrings.shopNow,
            buttonFunction: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ));
            },
            isThereButton: true)
        : Scaffold(
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
                          function: () {
                            cartProvider.clearCart();
                          },
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
                      itemCount: cartItemsList.length,
                      itemBuilder: (context, index) {
                        return ChangeNotifierProvider.value(
                            value: cartItemsList[index],
                            child: CartCardWidget(
                              quantity: cartItemsList[index].quantity,
                            ));
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

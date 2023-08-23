import 'package:electronic_shop/resources/routes_manager.dart';
import 'package:electronic_shop/widgets/empty_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/cart_provider.dart';
import '../../provider/products_provider.dart';
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
              Navigator.pushNamed(
                context,
                Routes.homeRoute,
              );
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
                          function: () async {
                            await cartProvider.clearWholeCart();
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
                        final cartModel = cartItemsList[index];
                        final quantityController = TextEditingController(
                            text: cartModel.quantity.toString());
                        return ChangeNotifierProvider.value(
                            value: cartItemsList[index],
                            child: CartCardWidget(
                              quantity: cartItemsList[index].quantity,
                              quantityController: quantityController,
                            ));
                      }),
                ),
              ],
            ));
  }

  Widget _checkOut() {
    Size size = Utils(context).screenSize;

    final cartProvider = Provider.of<CartProvider>(context);
    final cartItemsList = cartProvider.getCartItems.values.toList();

    double totalCartPrice = 0.0;

    for (var cartModel in cartItemsList) {
      final productProvider = Provider.of<ProductProvider>(context);
      final currentProduct =
          productProvider.findProductById(cartModel.productId);

      double usedPrice = currentProduct.isProductOnSale
          ? currentProduct.productSalePrice
          : currentProduct.productPrice;

      double productTotalPrice = usedPrice * cartModel.quantity;
      totalCartPrice += productTotalPrice;
    }

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
              "${AppStrings.total}\$$totalCartPrice",
              style: const TextStyle(
                  fontSize: AppSize.s20, fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}

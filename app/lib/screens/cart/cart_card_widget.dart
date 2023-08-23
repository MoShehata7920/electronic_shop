import 'package:electronic_shop/models/cart_model.dart';
import 'package:electronic_shop/provider/products_provider.dart';
import 'package:electronic_shop/resources/icons_manager.dart';
import 'package:electronic_shop/resources/routes_manager.dart';
import 'package:electronic_shop/resources/values_manager.dart';
import 'package:electronic_shop/widgets/heart_widget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../provider/cart_provider.dart';
import '../../provider/wishlist_provider.dart';
import '../../services/utils.dart';

class CartCardWidget extends StatefulWidget {
  const CartCardWidget(
      {super.key, required this.quantity, required this.quantityController});
  final int quantity;
  final TextEditingController quantityController;

  @override
  State<CartCardWidget> createState() => _CartCardWidgetState();
}

class _CartCardWidgetState extends State<CartCardWidget> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).screenSize;
    double cardHeight = size.height * 0.13;

    final productProvider = Provider.of<ProductProvider>(context);
    final cartModel = Provider.of<CartModel>(context);
    final cartProvider = Provider.of<CartProvider>(context);

    final getCurrentProduct =
        productProvider.findProductById(cartModel.productId);

    double usedPrice = getCurrentProduct.isProductOnSale
        ? getCurrentProduct.productSalePrice
        : getCurrentProduct.productPrice;

    double totalPrice = usedPrice * int.parse(widget.quantityController.text);

    final wishListProvider = Provider.of<WishListProvider>(context);
    bool? isInWishedList =
        wishListProvider.getWishedItems.containsKey(cartModel.productId);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, Routes.productScreenRoute,
            arguments: cartModel.productId);
      },
      child: Flex(
        direction: Axis.horizontal,
        children: [
          Flexible(
            child: SizedBox(
              height: cardHeight,
              child: Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(AppSize.s12)),
                child: Row(
                  children: [
                    SizedBox(
                      height: cardHeight,
                      child: FancyShimmerImage(
                        imageUrl: getCurrentProduct.productImage,
                        width: size.width * 0.25,
                        height: cardHeight,
                        boxFit: BoxFit.fill,
                      ),
                    ),
                    const SizedBox(
                      width: AppSize.s10,
                    ),
                    Flexible(
                      flex: 2,
                      child: SizedBox(
                        width: size.width * 0.45,
                        height: cardHeight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              child: Text(
                                getCurrentProduct.productName,
                                style: const TextStyle(
                                    fontSize: AppSize.s16,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                            const SizedBox(
                              height: AppSize.s15,
                            ),
                            Row(
                              children: [
                                _quantityController(
                                    buttonFunction: () {
                                      if (widget.quantityController.text ==
                                          "1") {
                                        return;
                                      } else {
                                        cartProvider.reduceQuantityByOne(
                                            cartId: cartModel.id,
                                            productId: cartModel.productId,
                                            quantity: cartModel.quantity);
                                        setState(() {
                                          widget.quantityController.text =
                                              (int.parse(widget
                                                          .quantityController
                                                          .text) -
                                                      1)
                                                  .toString();
                                        });
                                      }
                                    },
                                    buttonColor: Colors.red,
                                    buttonIcon: AppIcons.minus),
                                Flexible(
                                  child: TextField(
                                    controller: widget.quantityController,
                                    keyboardType: TextInputType.number,
                                    maxLines: 1,
                                    decoration: const InputDecoration(
                                        focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(
                                                color: Colors.green))),
                                    textAlign: TextAlign.center,
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(
                                        RegExp('[0-9]'),
                                      ),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        if (value.isEmpty) {
                                          widget.quantityController.text = '1';
                                        } else {
                                          return;
                                        }
                                      });
                                    },
                                  ),
                                ),
                                _quantityController(
                                    buttonFunction: () async {
                                      await cartProvider.increaseQuantityByOne(
                                          cartId: cartModel.id,
                                          productId: cartModel.productId,
                                          quantity: cartModel.quantity);
                                      setState(() {
                                        widget.quantityController.text =
                                            (int.parse(widget.quantityController
                                                        .text) +
                                                    1)
                                                .toString();
                                      });
                                    },
                                    buttonColor: Colors.green,
                                    buttonIcon: AppIcons.add)
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const Spacer(),
                    Flexible(
                        flex: 1,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                await cartProvider.removeOneItem(
                                    cartId: cartModel.id,
                                    productId: cartModel.productId,
                                    quantity: cartModel.quantity);
                              },
                              child: const Icon(
                                AppIcons.cartBadgeMinus,
                                color: Colors.red,
                                size: AppSize.s20,
                              ),
                            ),
                            const SizedBox(
                              height: AppSize.s15,
                            ),
                            HeartButton(
                              productId: cartModel.productId,
                              isInWishList: isInWishedList,
                            ),
                            const SizedBox(
                              height: AppSize.s15,
                            ),
                            Flexible(
                              child: Text(
                                totalPrice.toString(),
                                style: const TextStyle(fontSize: AppSize.s14),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _quantityController(
      {required Function buttonFunction,
      required Color buttonColor,
      required IconData buttonIcon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppPadding.p5),
      child: Material(
        color: buttonColor,
        borderRadius: BorderRadius.circular(AppSize.s12),
        child: Padding(
          padding: const EdgeInsets.all(AppPadding.p5),
          child: InkWell(
            onTap: () {
              buttonFunction();
            },
            child: Icon(
              buttonIcon,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

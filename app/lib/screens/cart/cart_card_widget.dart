import 'package:electronic_shop/models/cart_model.dart';
import 'package:electronic_shop/provider/products_provider.dart';
import 'package:electronic_shop/resources/icons_manager.dart';
import 'package:electronic_shop/resources/values_manager.dart';
import 'package:electronic_shop/widgets/heart_widget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../provider/cart_provider.dart';
import '../../services/utils.dart';
import '../product_screen/product_screen.dart';

class CartCardWidget extends StatefulWidget {
  const CartCardWidget({super.key, required this.quantity});
  final int quantity;

  @override
  State<CartCardWidget> createState() => _CartCardWidgetState();
}

class _CartCardWidgetState extends State<CartCardWidget> {
  final _quantityTextController = TextEditingController();

  @override
  void initState() {
    _quantityTextController.text = widget.quantity.toString();
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

    double totalPrice = usedPrice * int.parse(_quantityTextController.text);

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ProductScreen(cartModel.productId),
        ));
      },
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Flexible(
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
                                    if (_quantityTextController.text == "1") {
                                      return;
                                    } else {
                                      setState(() {
                                        cartProvider.reduceQuantityByOne(
                                          cartModel.productId,
                                        );
                                        _quantityTextController.text =
                                            (int.parse(_quantityTextController
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
                                  controller: _quantityTextController,
                                  keyboardType: TextInputType.number,
                                  maxLines: 1,
                                  decoration: const InputDecoration(
                                      focusedBorder: UnderlineInputBorder(
                                          borderSide:
                                              BorderSide(color: Colors.green))),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                      RegExp('[0-9]'),
                                    ),
                                  ],
                                  onChanged: (value) {
                                    setState(() {
                                      if (value.isEmpty) {
                                        _quantityTextController.text = '1';
                                      } else {
                                        return;
                                      }
                                    });
                                  },
                                ),
                              ),
                              _quantityController(
                                  buttonFunction: () {
                                    setState(() {
                                      cartProvider.increaseQuantityByOne(
                                        cartModel.productId,
                                      );
                                      _quantityTextController.text = (int.parse(
                                                  _quantityTextController
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
                            onTap: () {
                              cartProvider.removeOneItem(cartModel.productId);
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
                          const HeartButton(),
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
    _quantityTextController.dispose();
    super.dispose();
  }
}

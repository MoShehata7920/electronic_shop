// ignore_for_file: no_logic_in_create_state, unnecessary_null_comparison

import 'package:electronic_shop/resources/assets_manager.dart';
import 'package:electronic_shop/resources/firebase_constants.dart';
import 'package:electronic_shop/resources/icons_manager.dart';
import 'package:electronic_shop/resources/routes_manager.dart';
import 'package:electronic_shop/resources/strings_manager.dart';
import 'package:electronic_shop/services/global_methods.dart';
import 'package:electronic_shop/widgets/heart_widget.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../../provider/cart_provider.dart';
import '../../provider/products_provider.dart';
import '../../provider/wishlist_provider.dart';
import '../../resources/values_manager.dart';
import '../../services/utils.dart';

class ProductScreen extends StatefulWidget {
  final Object? productId;

  const ProductScreen(this.productId, {Key? key}) : super(key: key);

  @override
  ProductScreenState createState() => ProductScreenState(productId as String);
}

class ProductScreenState extends State<ProductScreen> {
  final _productScreenQuantityController = TextEditingController(text: "1");

  String productId;
  ProductScreenState(this.productId);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _getContentWidget(context),
    );
  }

  Widget _getContentWidget(BuildContext context) {
    final Color textColor = Utils(context).textColor;
    Size size = Utils(context).screenSize;

    final productProvider = Provider.of<ProductProvider>(context);
    final getCurrentProduct = productProvider.findProductById(productId);

    double usedPrice = getCurrentProduct.isProductOnSale
        ? getCurrentProduct.productSalePrice
        : getCurrentProduct.productPrice;

    final wishListProvider = Provider.of<WishListProvider>(context);
    bool? isInWishedList = wishListProvider.getWishedItems
        .containsKey(getCurrentProduct.productId);

    return CustomScrollView(slivers: [
      SliverAppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(AppIcons.leftArrow)),
        iconTheme: IconThemeData(color: textColor, size: AppSize.s22),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppPadding.p10),
            child: IconButton(
              icon: const Icon(
                AppIcons.share,
                size: AppSize.s30,
              ),
              onPressed: () {},
            ),
          )
        ],
        expandedHeight: size.height * 0.6,
        elevation: AppSize.s0,
        snap: true,
        floating: true,
        stretch: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        flexibleSpace: FlexibleSpaceBar(
            stretchModes: const [
              StretchMode.zoomBackground,
            ],
            background: Image.network(
              getCurrentProduct.productImage,
              fit: BoxFit.fill,
              width: size.width * 0.2,
              height: size.height * 0.12,
            )),
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(AppSize.s45),
            child: Transform.translate(
              offset: const Offset(AppSize.s0, AppSize.s1),
              child: Container(
                height: AppSize.s45,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.9),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppSize.s30),
                    topRight: Radius.circular(AppSize.s30),
                  ),
                ),
                child: Center(
                    child: Container(
                  width: AppSize.s50,
                  height: AppSize.s8,
                  decoration: BoxDecoration(
                    color: Colors.cyan,
                    borderRadius: BorderRadius.circular(AppSize.s10),
                  ),
                )),
              ),
            )),
      ),
      SliverList(
          delegate: SliverChildListDelegate([
        Container(
            height: size.height,
            color: Theme.of(context).cardColor,
            // padding: const EdgeInsets.symmetric(
            //     horizontal: AppSize.s20, vertical: AppSize.s5),
            child: Column(
              children: [
                const SizedBox(
                  height: AppSize.s35,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p20, vertical: AppPadding.p5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          getCurrentProduct.productName,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: AppSize.s24),
                        ),
                      ),
                      HeartButton(
                        productId: getCurrentProduct.productId,
                        isInWishList: isInWishedList,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p20, vertical: AppPadding.p5),
                  child: ExpandableText(
                    getCurrentProduct.productDescription,
                    expandText: AppStrings.showMore,
                    maxLines: 5,
                    linkColor: Colors.cyan,
                    animation: true,
                    collapseOnTextTap: true,
                    hashtagStyle: const TextStyle(
                      color: Colors.cyan,
                    ),
                  ),
                ),
                const SizedBox(
                  height: AppSize.s20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppPadding.p20, vertical: AppPadding.p5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                  text: usedPrice.toString(),
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: AppSize.s22),
                                  children: [
                                    TextSpan(
                                      text: " / ${AppStrings.piece}",
                                      style: TextStyle(
                                          color: textColor,
                                          fontSize: AppSize.s18,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ]))),
                      Material(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        child: Padding(
                          padding: const EdgeInsets.all(AppPadding.p8),
                          child: Text(
                            AppStrings.freeShipping,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: AppSize.s15,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: AppSize.s30,
                ),
                SizedBox(
                  width: size.width * 0.4,
                  child: Row(
                    children: [
                      _quantityController(
                          buttonFunction: () {
                            if (_productScreenQuantityController.text == "1") {
                              return;
                            } else {
                              setState(() {
                                _productScreenQuantityController.text =
                                    (int.parse(_productScreenQuantityController
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
                          controller: _productScreenQuantityController,
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          decoration: const InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.green))),
                          textAlign: TextAlign.center,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp('[0-9]'),
                            ),
                          ],
                          onChanged: (value) {
                            setState(() {
                              if (value.isEmpty) {
                                _productScreenQuantityController.text = '1';
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
                              _productScreenQuantityController.text =
                                  (int.parse(_productScreenQuantityController
                                              .text) +
                                          1)
                                      .toString();
                            });
                          },
                          buttonColor: Colors.green,
                          buttonIcon: AppIcons.add)
                    ],
                  ),
                ),
                const SizedBox(
                  height: AppSize.s100,
                ),
                _bottomROw()
              ],
            ))
      ])),
    ]);
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

  Widget _bottomROw() {
    final Color textColor = Utils(context).textColor;

    final productProvider = Provider.of<ProductProvider>(context);
    final getCurrentProduct = productProvider.findProductById(productId);

    double usedPrice = getCurrentProduct.isProductOnSale
        ? getCurrentProduct.productSalePrice
        : getCurrentProduct.productPrice;

    double totalPrice =
        usedPrice * int.parse(_productScreenQuantityController.text);

    final cartProvider = Provider.of<CartProvider>(context);
    final wishListProvider = Provider.of<WishListProvider>(context);

    bool? isInCart =
        cartProvider.getCartItems.containsKey(getCurrentProduct.productId);

    return SizedBox(
      height: AppSize.s120,
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).canvasColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppSize.s12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppPadding.p20, vertical: AppPadding.p8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.total,
                    style: const TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                        fontSize: AppSize.s24),
                  ),
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: totalPrice.toString(),
                      style: const TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: AppSize.s24,
                        // Adjust the font size as needed
                      ),
                      children: [
                        TextSpan(
                          text:
                              "/${_productScreenQuantityController.text}${AppStrings.piece}",
                          style: TextStyle(
                            color: textColor,
                            fontSize:
                                AppSize.s20, // Adjust the font size as needed
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Material(
                color: Colors.green,
                borderRadius: BorderRadius.circular(AppSize.s12),
                child: InkWell(
                  onTap: () async {
                    final User? user = authInstance.currentUser;
                    if (user == null) {
                      GlobalMethods.warningDialog(
                        title: AppStrings.authError,
                        subtitle: AppStrings.pleaseSignIn,
                        function: () {},
                        warningIcon: JsonAssets.error,
                        context: context,
                        navigateTo: () {
                          Navigator.pushReplacementNamed(
                              context, Routes.loginScreenRoute);
                        },
                      );
                      return;
                    }
                    await cartProvider.addToCart(
                        productId: getCurrentProduct.productId,
                        quantity:
                            int.parse(_productScreenQuantityController.text),
                        context: context);
                    if (user != null) {
                      await cartProvider.fetchCartItems();
                      await wishListProvider.fetchWishList();
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(AppPadding.p8),
                    child: Text(
                      isInCart ? AppStrings.inCart : AppStrings.addToCart,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: AppSize.s18,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _productScreenQuantityController.dispose();
    super.dispose();
  }
}

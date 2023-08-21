// ignore_for_file: use_build_context_synchronously

import 'package:admin_panel/resources/assets_manager.dart';
import 'package:admin_panel/resources/routes_manager.dart';
import 'package:admin_panel/resources/values_manager.dart';
import 'package:admin_panel/services/global_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_network/image_network.dart';
import '../resources/strings_manager.dart';
import '../services/utils.dart';

class ProductWidget extends StatefulWidget {
  const ProductWidget({
    Key? key,
    required this.productId,
  }) : super(key: key);
  final String productId;

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  String productTitle = '';
  String productDescription = '';
  String productCategory = '';
  String? imageUrl;
  String productPrice = '0.0';
  String productSalePrice = '';
  bool isOnSale = false;
  bool isDescriptionVisible = false;
  // double expandedHeight = 300.0; // Adjust this value as needed
  // double initialHeight = 50.0; // Adjust this value as needed

  @override
  void initState() {
    getProductsData(context);
    super.initState();
  }

  Future<void> getProductsData(BuildContext context) async {
    try {
      final DocumentSnapshot productsDoc = await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.productId)
          .get();
      setState(() {
        productTitle = productsDoc.get('title');
        productDescription = productsDoc.get('description');
        productCategory = productsDoc.get('productCategoryName');
        imageUrl = productsDoc.get('imageUrl');
        productPrice = productsDoc.get('price');
        productSalePrice = productsDoc.get('salePrice');
        isOnSale = productsDoc.get('isOnSale');
      });
    } catch (error) {
      GlobalMethods.errorDialog(title: '$error', context: context);
    } finally {}
  }

  double getInitialHeight() {
    // Define the initial height of the widget without description
    // You can adjust this value based on your design
    return 150.0;
  }

  double getExpandedHeight() {
    // Define the expanded height when description is visible
    // You can adjust this value based on your design
    return 250.0;
  }

  @override
  Widget build(BuildContext context) {
    return _buildScreenWidget(context);
  }

  Widget _buildScreenWidget(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final textColor = Utils(context).textColor;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
      height: 200,
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Material(
          borderRadius: BorderRadius.circular(AppSize.s12),
          color: Theme.of(context).cardColor.withOpacity(0.6),
          child: MouseRegion(
            onEnter: (event) {
              setState(() {
                isDescriptionVisible = true;
              });
            },
            onExit: (event) {
              setState(() {
                isDescriptionVisible = false;
              });
            },
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                          flex: 3,
                          child: ImageNetwork(
                            image: imageUrl!,
                            height: size.width * 0.12,
                            fitWeb: BoxFitWeb.fill,
                            width: size.width * 0.12,
                          )),
                      PopupMenuButton(
                          itemBuilder: (context) => [
                                PopupMenuItem(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, Routes.editProductScreenRoute,
                                        arguments: widget.productId);
                                  },
                                  value: 1,
                                  child: Text(AppStrings.edit),
                                ),
                                PopupMenuItem(
                                  onTap: () async {
                                    GlobalMethods.warningDialog(
                                      title: 'Delete?',
                                      subtitle: 'Press okay to confirm',
                                      warningIcon: JsonAssets.warning,
                                      function: () async {
                                        await FirebaseFirestore.instance
                                            .collection('products')
                                            .doc(widget.productId)
                                            .delete();
                                        await Fluttertoast.showToast(
                                          msg: "Product has been deleted",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.CENTER,
                                          timeInSecForIosWeb: 1,
                                        );
                                        while (Navigator.canPop(context)) {
                                          Navigator.pop(context);
                                        }
                                      },
                                      context: context,
                                    );
                                  },
                                  value: 2,
                                  child: Text(
                                    AppStrings.delete,
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ),
                              ])
                    ],
                  ),
                  const SizedBox(
                    height: AppSize.s2,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 1,
                        child: Row(
                          children: [
                            Text(
                              isOnSale ? productSalePrice : productPrice,
                              style: const TextStyle(
                                  color: Colors.green, fontSize: AppSize.s18),
                            ),
                            const SizedBox(
                              width: AppSize.s8,
                            ),
                            Visibility(
                                visible: isOnSale,
                                child: Text(
                                  productPrice,
                                  style: TextStyle(
                                      decoration: TextDecoration.lineThrough,
                                      color: textColor),
                                )),
                          ],
                        ),
                      ),
                      Flexible(
                        child: Text(
                          productCategory,
                          style: const TextStyle(
                              color: Colors.cyan, fontSize: AppSize.s22),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSize.s2,
                  ),
                  Row(
                    children: [
                      Flexible(
                        flex: 1,
                        child: Text(
                          productTitle,
                          style: TextStyle(
                            color: textColor,
                            fontSize: AppSize.s24,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                          maxLines: 2,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: AppSize.s2,
                  ),
                  Flexible(
                    child: Visibility(
                        visible: isDescriptionVisible,
                        child: Text(
                          productDescription,
                          maxLines: 10,
                          style: TextStyle(
                              color: textColor,
                              overflow: TextOverflow.ellipsis),
                        )),
                  ),
                  const SizedBox(
                    height: AppSize.s2,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

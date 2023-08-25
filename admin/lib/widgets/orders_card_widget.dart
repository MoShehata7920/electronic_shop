// ignore_for_file: use_build_context_synchronously

import 'package:admin_panel/resources/strings_manager.dart';
import 'package:admin_panel/services/global_method.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_network/image_network.dart';
import '../resources/values_manager.dart';
import '../services/utils.dart';

class OrderCardWidget extends StatefulWidget {
  const OrderCardWidget({super.key, required this.orderId});
  final String orderId;

  @override
  State<OrderCardWidget> createState() => _OrderCardWidgetState();
}

class _OrderCardWidgetState extends State<OrderCardWidget> {
  String? imageUrl;
  String productTitle = '';
  String orderedQuantity = '';
  String productTotalPrice = '';
  String userName = '';
  Timestamp? orderDate;
  bool isDelivered = false;

  @override
  void initState() {
    getOrdersData(context);
    super.initState();
  }

  Future<void> getOrdersData(BuildContext context) async {
    try {
      final DocumentSnapshot productsDoc = await FirebaseFirestore.instance
          .collection('orders')
          .doc(widget.orderId)
          .get();
      setState(() {
        imageUrl = productsDoc.get('productImage');
        productTitle = productsDoc.get('productName');
        orderedQuantity = productsDoc.get('orderedQuantity').toString();
        productTotalPrice = productsDoc.get('productTotalPrice').toString();
        userName = productsDoc.get('userName');
        isDelivered = productsDoc.get('isOrderDelivered');
        orderDate = productsDoc.get('oderDate');
      });
    } catch (error) {
      GlobalMethods.errorDialog(title: '$error', context: context);
    } finally {}
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Material(
        borderRadius: BorderRadius.circular(AppSize.s12),
        color: Theme.of(context).cardColor.withOpacity(0.6),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppSize.s12),
          onTap: () {},
          child: Padding(
              padding: const EdgeInsets.all(AppPadding.p8),
              child: _buildScreenWidget(context)),
        ),
      ),
    );
  }

  Widget _buildScreenWidget(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final textColor = Utils(context).textColor;

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
            flex: 2,
            child: ImageNetwork(
              image: imageUrl!,
              height: size.width * 0.12,
              fitWeb: BoxFitWeb.fill,
              width: size.width * 0.12,
            )),
        const SizedBox(
          width: AppSize.s15,
        ),
        Flexible(
          flex: 5,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                productTitle,
                style: TextStyle(
                  color: textColor,
                  fontSize: AppSize.s27,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
                maxLines: 2,
              ),
              RichText(
                  text: TextSpan(
                      text: "$orderedQuantity${AppStrings.pieceFor}",
                      style: TextStyle(color: textColor, fontSize: AppSize.s18),
                      children: [
                    TextSpan(
                      text: " $productTotalPrice${AppStrings.egyptianPound}",
                      style: const TextStyle(
                        color: Colors.green,
                        fontSize: AppSize.s18,
                      ),
                    ),
                  ])),
              RichText(
                  text: TextSpan(
                      text: AppStrings.by,
                      style: const TextStyle(
                          color: Colors.cyan, fontSize: AppSize.s18),
                      children: [
                    TextSpan(
                      text: userName,
                      style: TextStyle(
                        color: textColor,
                        fontSize: AppSize.s18,
                      ),
                    ),
                  ])),
              Text(
                '${orderDate!.toDate().day}/${orderDate!.toDate().month}/${orderDate!.toDate().year}',
                style: TextStyle(
                    color: textColor,
                    fontSize: AppSize.s18,
                    fontWeight: FontWeight.w100),
              ),
            ],
          ),
        ),
        const Spacer(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Is Delivered?",
              style: TextStyle(
                color: textColor,
                fontSize: AppSize.s25,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: AppSize.s5,
            ),
            Checkbox(
              value: isDelivered,
              onChanged: (bool? newValue) {
                setState(() {
                  if (newValue != null) {
                    setState(() {
                      isDelivered = newValue;
                    });
                    updateDeliveryStatus(newValue);
                  }
                });
              },
              focusColor: Colors.green,
              activeColor: Colors.green,
            ),
          ],
        ),
      ],
    );
  }

  Future<void> updateDeliveryStatus(bool isOrderDelivered) async {
    try {
      await FirebaseFirestore.instance
          .collection('orders')
          .doc(widget.orderId)
          .update({'isOrderDelivered': isOrderDelivered});

      Fluttertoast.showToast(
        msg: "Delivery status updated successfully",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
      );
    } catch (error) {
      GlobalMethods.errorDialog(title: '$error', context: context);
    }
  }
}

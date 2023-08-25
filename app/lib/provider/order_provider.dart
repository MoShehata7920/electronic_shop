// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronic_shop/models/orders_model.dart';
import 'package:electronic_shop/resources/strings_manager.dart';
import 'package:electronic_shop/resources/values_manager.dart';
import 'package:electronic_shop/services/global_methods.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

class OrderProvider with ChangeNotifier {
  static final List<OrderModel> _ordersList = [];

  List<OrderModel> get getOrders {
    return _ordersList;
  }

  Future<void> fetchOrders() async {
    _ordersList.clear();

    await FirebaseFirestore.instance
        .collection('orders')
        .get()
        .then((QuerySnapshot ordersSnapShot) {
      for (var element in ordersSnapShot.docs) {
        _ordersList.insert(
            0,
            OrderModel(
              orderId: element.get('orderId'),
              userId: element.get('userId'),
              productId: element.get('productId'),
              productName: element.get('productName'),
              userName: element.get('userName'),
              productTotalPrice: element.get('productTotalPrice').toString(),
              productImage: element.get('productImage'),
              orderedQuantity: element.get('orderedQuantity').toString(),
              isDelivered: element.get('isOrderDelivered'),
              orderDate: element.get('oderDate'),
            ));
      }
    });
    notifyListeners();
  }

  Future<void> order({
    required BuildContext context,
    required String productId,
    required String productName,
    required double productTotalPrice,
    required String productImage,
    required int orderedQuantity,
    required String userId,
    required String? userName,
  }) async {
    final orderId = const Uuid().v4();

    try {
      await FirebaseFirestore.instance.collection('orders').doc(orderId).set({
        'orderId': orderId,
        'userId': userId,
        'productId': productId,
        'productName': productName,
        'productTotalPrice': productTotalPrice,
        'productImage': productImage,
        'orderedQuantity': orderedQuantity,
        'userName': userName,
        'isOrderDelivered': false,
        'oderDate': Timestamp.now(),
      });

      Fluttertoast.showToast(
          msg: AppStrings.orderedSuccessfully,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey.shade600,
          textColor: Colors.white,
          fontSize: AppSize.s16);
    } catch (error) {
      GlobalMethods.errorDialog(title: error.toString(), context: context);
    } finally {}
  }
}

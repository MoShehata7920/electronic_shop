import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderModel with ChangeNotifier {
  final String orderId,
      userId,
      productId,
      productName,
      userName,
      productTotalPrice,
      productImage,
      orderedQuantity;
  final bool isDelivered;
  final Timestamp orderDate;

  OrderModel(
      {required this.orderId,
      required this.userId,
      required this.productId,
      required this.productName,
      required this.userName,
      required this.productTotalPrice,
      required this.productImage,
      required this.orderedQuantity,
      required this.isDelivered,
      required this.orderDate});
}

import 'package:flutter/material.dart';

class RecentlyViewedProductsModel with ChangeNotifier {
  final String id, productId;

  RecentlyViewedProductsModel({required this.id, required this.productId});
}

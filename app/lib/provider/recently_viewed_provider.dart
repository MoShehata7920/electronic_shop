import 'package:electronic_shop/models/recently_viewed_model.dart';
import 'package:flutter/material.dart';

class RecentlyViewedProductsProvider with ChangeNotifier {
  final Map<String, RecentlyViewedProductsModel> _recentlyViewedItems = {};

  Map<String, RecentlyViewedProductsModel> get getRecentlyViewedItems {
    return _recentlyViewedItems;
  }

  void addProductToRecentlyViewedList(String productId) {
    _recentlyViewedItems.putIfAbsent(
        productId,
        () => RecentlyViewedProductsModel(
              id: DateTime.now().toString(),
              productId: productId,
            ));

    notifyListeners();
  }

  void removeProductFromRecentlyViewedList(String productId) {
    _recentlyViewedItems.remove(
      productId,
    );
    notifyListeners();
  }

  void clearRecentlyViewedProductsList() {
    _recentlyViewedItems.clear();
    notifyListeners();
  }
}

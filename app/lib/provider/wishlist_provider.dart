import 'package:flutter/material.dart';
import '../models/wishlist_model.dart';

class WishListProvider with ChangeNotifier {
  final Map<String, WishListModel> _wishedItems = {};

  Map<String, WishListModel> get getWishedItems {
    return _wishedItems;
  }

  void addRemoveProductWished(String productId) {
    if (_wishedItems.containsKey(productId)) {
      removeProductFromWishList(productId);
    } else {
      _wishedItems.putIfAbsent(
          productId,
          () => WishListModel(
              id: DateTime.now().toString(), productId: productId));
    }
    notifyListeners();
  }

  void removeProductFromWishList(String productId) {
    _wishedItems.remove(
      productId,
    );
    notifyListeners();
  }

  void clearWishList() {
    _wishedItems.clear();
    notifyListeners();
  }
}

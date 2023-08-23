import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/products_model.dart';

class ProductProvider with ChangeNotifier {
  static final List<ProductModel> _productsList = [];

  List<ProductModel> get getProducts {
    return _productsList;
  }

  List<ProductModel> get getOnSaleProducts {
    return _productsList.where((element) => element.isProductOnSale).toList();
  }

  ProductModel findProductById(String productId) {
    return _productsList
        .firstWhere((element) => element.productId == productId);
  }

  List<ProductModel> findByCategory(String categoryName) {
    return _productsList
        .where((element) => element.productCategoryName
            .toLowerCase()
            .contains(categoryName.toLowerCase()))
        .toList();
  }

  List<ProductModel> search(String searchText) {
    return _productsList
        .where((element) => element.productName
            .toLowerCase()
            .contains(searchText.toLowerCase()))
        .toList();
  }

  Future<void> fetchProducts() async {
    _productsList.clear();

    await FirebaseFirestore.instance
        .collection('products')
        .get()
        .then((QuerySnapshot productSnapShot) {
      for (var element in productSnapShot.docs) {
        _productsList.insert(
            0,
            ProductModel(
                element.get('id'),
                element.get('title'),
                element.get('description'),
                element.get('imageUrl'),
                element.get('productCategoryName'),
                double.parse(element.get('price')),
                double.parse(element.get('salePrice')),
                element.get('isOnSale')));
      }
    });
    notifyListeners();
  }
}

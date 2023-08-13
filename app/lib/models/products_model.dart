import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier {
  final String productId, productName, productImage, productCategoryName;
  final double productPrice, productSalePrice;
  final bool isProductOnSale;

  ProductModel(
      this.productId,
      this.productName,
      this.productImage,
      this.productCategoryName,
      this.productPrice,
      this.productSalePrice,
      this.isProductOnSale);
}

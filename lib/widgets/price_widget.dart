import 'package:electronic_shop/resources/values_manager.dart';
import 'package:flutter/material.dart';
import '../services/utils.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget(
      {super.key,
      required this.salePrice,
      required this.price,
      required this.isProductsOnSale});

  final double salePrice, price;
  final bool isProductsOnSale;

  @override
  Widget build(BuildContext context) {
    final Color textColor = Utils(context).textColor;

    double usedPrice = isProductsOnSale ? salePrice : price;

    return FittedBox(
      child: Column(
        children: [
          Text(
            "\$$usedPrice",
            style: const TextStyle(
              color: Colors.green,
              fontSize: AppSize.s18,
            ),
          ),
          const SizedBox(
            width: AppSize.s5,
          ),
          Visibility(
            visible: isProductsOnSale ? true : false,
            child: Text(
              "\$$price",
              style: TextStyle(
                  color: textColor,
                  fontSize: AppSize.s14,
                  decoration: TextDecoration.lineThrough),
            ),
          ),
        ],
      ),
    );
  }
}

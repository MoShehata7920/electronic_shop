import 'package:electronic_shop/resources/values_manager.dart';
import 'package:flutter/material.dart';
import '../services/utils.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final Color textColor = Utils(context).textColor;

    return FittedBox(
      child: Column(
        children: [
          const Text(
            "11000.50",
            style: TextStyle(
              color: Colors.green,
              fontSize: AppSize.s18,
            ),
          ),
          const SizedBox(
            width: AppSize.s5,
          ),
          Text(
            "12000.50",
            style: TextStyle(
                color: textColor,
                fontSize: AppSize.s14,
                decoration: TextDecoration.lineThrough),
          ),
        ],
      ),
    );
  }
}

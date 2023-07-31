import 'package:electronic_shop/resources/icons_manager.dart';
import 'package:electronic_shop/resources/values_manager.dart';
import 'package:electronic_shop/services/utils.dart';
import 'package:flutter/material.dart';

class HeartButton extends StatelessWidget {
  const HeartButton({super.key});

  @override
  Widget build(BuildContext context) {
    final Color textColor = Utils(context).textColor;

    return GestureDetector(
      onTap: () {},
      child: Icon(
        AppIcons.love,
        size: AppSize.s18,
        color: textColor,
      ),
    );
  }
}

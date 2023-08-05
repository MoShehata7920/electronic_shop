import 'package:electronic_shop/resources/icons_manager.dart';
import 'package:flutter/material.dart';
import '../resources/values_manager.dart';
import '../services/utils.dart';

class BackArrowButton extends StatelessWidget {
  const BackArrowButton({super.key});
  

  @override
  Widget build(BuildContext context) {
    final Color textColor = Utils(context).textColor;

    return IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon:  Icon(AppIcons.leftArrow,color: textColor ,size: AppSize.s22,));
  }
}

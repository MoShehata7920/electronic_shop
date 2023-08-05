import 'package:electronic_shop/resources/values_manager.dart';
import 'package:electronic_shop/services/utils.dart';
import 'package:electronic_shop/widgets/back_arrow_button.dart';
import 'package:electronic_shop/widgets/empty_screen.dart';
import 'package:flutter/material.dart';

class EmptyInnerScreen extends StatelessWidget {
  const EmptyInnerScreen(
      {super.key,
      required this.screenTitle,
      required this.emptyScreenAsset,
      required this.emptyScreenTitle,
      required this.emptyScreenSubTitle,
      required this.buttonText,
      required this.buttonFunction});

  final String screenTitle,
      emptyScreenAsset,
      emptyScreenTitle,
      emptyScreenSubTitle,
      buttonText;
  final Function buttonFunction;

  @override
  Widget build(BuildContext context) {
    final Color textColor = Utils(context).textColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          screenTitle,
          style: TextStyle(
            color: textColor,
            fontSize: AppSize.s24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: const BackArrowButton(),
      ),
      body: EmptyScreenWidget(
          emptyScreenAsset: emptyScreenAsset,
          emptyScreenTitle: emptyScreenTitle,
          emptyScreenSubTitle: emptyScreenSubTitle,
          buttonText: buttonText,
          buttonFunction: buttonFunction),
    );
  }
}

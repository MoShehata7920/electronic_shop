import 'package:electronic_shop/resources/values_manager.dart';
import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    required this.buttonFunction,
    required this.buttonText,
    this.buttonColor = Colors.white38,
  }) : super(key: key);

  final Function buttonFunction;
  final String buttonText;
  final Color buttonColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor, // background (button) color
        ),
        onPressed: () {
          buttonFunction();
        },
        child: Text(
          buttonText,
          style: const TextStyle(
              color: Colors.white,
              fontSize: AppSize.s18,
              fontWeight: FontWeight.normal),
        ),
      ),
    );
  }
}

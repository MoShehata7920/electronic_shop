import 'package:electronic_shop/resources/strings_manager.dart';
import 'package:electronic_shop/services/functions.dart';
import 'package:flutter/material.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/values_manager.dart';
import '../../../widgets/auth_button.dart';
import '../../../widgets/carousel_widget.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final List<String> authBackGrounds = [
      ImagesAssets.lb1,
      ImagesAssets.lb2,
      ImagesAssets.lb3,
      ImagesAssets.lb4,
      ImagesAssets.lb5,
      ImagesAssets.lb6,
    ];

    return Scaffold(
      body: Stack(
        children: [
          SwiperWidget(
              carouselImages: authBackGrounds, isSwiperPaginationActive: false),
          Container(
            color: Colors.black.withOpacity(0.7),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(AppPadding.p20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  const SizedBox(
                    height: AppSize.s120,
                  ),
                  Text(
                    AppStrings.forgotPassword,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: AppSize.s30,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: AppSize.s30,
                  ),
                  Form(
                      key: _formKey,
                      child: TextFormField(
                        textInputAction: TextInputAction.done,
                        onEditingComplete: () {
                          _submitForgotPassword();
                        },
                        controller: _emailTextController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isValidEmail()) {
                            return null;
                          } else {
                            return AppStrings.notValidEmail;
                          }
                        },
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          hintText: AppStrings.email,
                          hintStyle: const TextStyle(color: Colors.white),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                      )),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  AuthButton(
                    buttonFunction: () {
                      _submitForgotPassword();
                    },
                    buttonText: AppStrings.resetNow,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void _submitForgotPassword() {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
    }
  }

  @override
  void dispose() {
    _emailTextController.dispose();
    super.dispose();
  }
}

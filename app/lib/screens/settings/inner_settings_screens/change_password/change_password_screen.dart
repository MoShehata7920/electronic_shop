// ignore_for_file: use_build_context_synchronously

import 'package:electronic_shop/resources/assets_manager.dart';
import 'package:electronic_shop/resources/firebase_constants.dart';
import 'package:electronic_shop/resources/icons_manager.dart';
import 'package:electronic_shop/resources/routes_manager.dart';
import 'package:electronic_shop/resources/strings_manager.dart';
import 'package:electronic_shop/resources/values_manager.dart';
import 'package:electronic_shop/services/global_methods.dart';
import 'package:electronic_shop/services/utils.dart';
import 'package:electronic_shop/widgets/auth_button.dart';
import 'package:electronic_shop/widgets/back_arrow_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmNewPasswordController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _oldPassFocusNode = FocusNode();
  final _newPassFocusNode = FocusNode();
  final _confirmPassFocusNode = FocusNode();
  var _obscureOldPasswordText = true;
  var _obscureNewPasswordText = true;
  var _obscureConfirmPasswordText = true;

  @override
  Widget build(BuildContext context) {
    final Color textColor = Utils(context).textColor;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          AppStrings.changePassword,
          style: TextStyle(
            color: textColor,
            fontSize: AppSize.s24,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: const BackArrowButton(),
      ),
      body: _buildContentWidget(),
    );
  }

  Widget _buildContentWidget() {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Form(
            key: _formKey,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(AppPadding.p65,
                      AppPadding.p65, AppPadding.p65, AppPadding.p65),
                  child: Lottie.asset(JsonAssets.changePassword)),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: _oldPasswordController,
                  focusNode: _oldPassFocusNode,
                  obscureText: _obscureOldPasswordText,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return AppStrings.notValidPassword;
                    }
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureOldPasswordText = !_obscureOldPasswordText;
                          });
                        },
                        child: Icon(
                          _obscureOldPasswordText
                              ? AppIcons.visible
                              : AppIcons.notVisible,
                          color: Colors.white,
                        )),
                    hintText: AppStrings.oldPassword,
                    hintStyle: const TextStyle(color: Colors.white),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: AppSize.s25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: TextFormField(
                  textInputAction: TextInputAction.next,
                  controller: _newPasswordController,
                  focusNode: _newPassFocusNode,
                  obscureText: _obscureNewPasswordText,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value!.isNotEmpty) {
                      return null;
                    } else {
                      return AppStrings.notValidPassword;
                    }
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureNewPasswordText = !_obscureNewPasswordText;
                          });
                        },
                        child: Icon(
                          _obscureNewPasswordText
                              ? AppIcons.visible
                              : AppIcons.notVisible,
                          color: Colors.white,
                        )),
                    hintText: AppStrings.newPassword,
                    hintStyle: const TextStyle(color: Colors.white),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: AppSize.s25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: TextFormField(
                  textInputAction: TextInputAction.done,
                  onEditingComplete: () {
                    if (_formKey.currentState!.validate()) {
                      _submitChangingPassword(context);
                    }
                  },
                  controller: _confirmNewPasswordController,
                  focusNode: _confirmPassFocusNode,
                  obscureText: _obscureConfirmPasswordText,
                  keyboardType: TextInputType.visiblePassword,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return AppStrings.notValidPassword;
                    }
                    if (value != _newPasswordController.text) {
                      return AppStrings.notMatchedPassword;
                    }
                    return null;
                  },
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obscureConfirmPasswordText =
                                !_obscureConfirmPasswordText;
                          });
                        },
                        child: Icon(
                          _obscureConfirmPasswordText
                              ? AppIcons.visible
                              : AppIcons.notVisible,
                          color: Colors.white,
                        )),
                    hintText: AppStrings.confirmNewPassword,
                    hintStyle: const TextStyle(color: Colors.white),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: AppSize.s32,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppPadding.p28),
                child: AuthButton(
                  buttonFunction: () {
                    if (_formKey.currentState!.validate()) {
                      _submitChangingPassword(context);
                    }
                  },
                  buttonText: AppStrings.resetNow,
                ),
              ),
            ]),
          ),
        ),
        if (_isLoading)
          Container(
            color: Colors.black.withOpacity(0.7),
            child: const Center(
              child: CircularProgressIndicator(color: Colors.white),
            ),
          ),
      ],
    );
  }

  bool _isLoading = false;

  void _submitChangingPassword(BuildContext context) async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
    });

    final User? user = authInstance.currentUser;

    if (isValid) {
      try {
        AuthCredential credential = EmailAuthProvider.credential(
          email: user!.email!,
          password: _oldPasswordController.text.trim(),
        );

        await user.reauthenticateWithCredential(credential);

        await user.updatePassword(_newPasswordController.text.trim());

        Fluttertoast.showToast(
            msg: AppStrings.changedPasswordSuccessfully,
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey.shade600,
            textColor: Colors.white,
            fontSize: AppSize.s16);

        Navigator.pushReplacementNamed(context, Routes.mainScreenRoute);

        final logger = Logger();
        logger.i("Successfully changed Password");
      } on FirebaseAuthException catch (error) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          GlobalMethods.errorDialog(
            title: "${error.message}",
            context: context,
          );
        });
      } catch (error) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          GlobalMethods.errorDialog(
            title: "$error",
            context: context,
          );
        });
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronic_shop/resources/firebase_constants.dart';
import 'package:electronic_shop/resources/icons_manager.dart';
import 'package:electronic_shop/resources/routes_manager.dart';
import 'package:electronic_shop/resources/strings_manager.dart';
import 'package:electronic_shop/services/functions.dart';
import 'package:electronic_shop/services/global_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/values_manager.dart';
import '../../../widgets/auth_button.dart';
import '../../../widgets/carousel_widget.dart';
import '../../../widgets/google_button.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameTextController = TextEditingController();
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
  final _addressTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _passFocusNode = FocusNode();
  var _obscureText = true;

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
                    AppStrings.welcome,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: AppSize.s30,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(
                    height: AppSize.s8,
                  ),
                  Text(
                    AppStrings.signUpToContinue,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: AppSize.s18,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: AppSize.s30,
                  ),
                  Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: _nameTextController,
                            keyboardType: TextInputType.name,
                            validator: (value) {
                              if (value!.length > 4) {
                                return null;
                              } else {
                                return AppStrings.notValidName;
                              }
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: AppStrings.fullName,
                              hintStyle: const TextStyle(color: Colors.white),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: AppSize.s12,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            onEditingComplete: () => FocusScope.of(context)
                                .requestFocus(_passFocusNode),
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
                          ),
                          const SizedBox(
                            height: AppSize.s12,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            controller: _passwordTextController,
                            focusNode: _passFocusNode,
                            obscureText: _obscureText,
                            keyboardType: TextInputType.visiblePassword,
                            validator: (value) {
                              if (value!.isPasswordValid()) {
                                return null;
                              } else {
                                return AppStrings.passwordFormat;
                              }
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _obscureText = !_obscureText;
                                    });
                                  },
                                  child: Icon(
                                    _obscureText
                                        ? AppIcons.visible
                                        : AppIcons.notVisible,
                                    color: Colors.white,
                                  )),
                              hintText: AppStrings.password,
                              hintStyle: const TextStyle(color: Colors.white),
                              errorMaxLines: 3,
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: AppSize.s12,
                          ),
                          TextFormField(
                            textInputAction: TextInputAction.done,
                            onEditingComplete: () {
                              if (_formKey.currentState!.validate()) {
                                _submitSignUp(context);
                              }
                            },
                            controller: _addressTextController,
                            keyboardType: TextInputType.text,
                            validator: (value) {
                              if (value!.length >= 4) {
                                return null;
                              } else {
                                return AppStrings.notValidAddress;
                              }
                            },
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: AppStrings.shippingAddress,
                              hintStyle: const TextStyle(color: Colors.white),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      )),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  AuthButton(
                    buttonFunction: () {
                      if (_formKey.currentState!.validate()) {
                        _submitSignUp(context);
                      }
                    },
                    buttonText: AppStrings.signUp,
                  ),
                  const SizedBox(
                    height: AppSize.s10,
                  ),
                  const GoogleButton(),
                  const SizedBox(
                    height: AppSize.s15,
                  ),
                  RichText(
                      text: TextSpan(
                          text: AppStrings.alreadyAUser,
                          style: const TextStyle(
                              color: Colors.white, fontSize: AppSize.s18),
                          children: [
                        TextSpan(
                            text: AppStrings.login,
                            style: const TextStyle(
                                color: Colors.cyan,
                                fontSize: AppSize.s18,
                                fontWeight: FontWeight.w600),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushNamed(
                                    context, Routes.loginScreenRoute);
                              }),
                      ]))
                ],
              ),
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
      ),
    );
  }

  bool _isLoading = false;

  void _submitSignUp(BuildContext context) async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
    });

    if (isValid) {
      try {
        _formKey.currentState!.save();
        final userCredential =
            await authInstance.createUserWithEmailAndPassword(
                email: _emailTextController.text.toLowerCase().trim(),
                password: _passwordTextController.text.trim());

        // to save the data
        final User? user = authInstance.currentUser;
        final uid = user!.uid;
        user.updateDisplayName(_nameTextController.text);
        user.reload();
        await FirebaseFirestore.instance.collection("users").doc(uid).set({
          'id': uid,
          'name': _nameTextController.text,
          'email': _emailTextController.text,
          'address': _addressTextController.text,
          'userWishList': [],
          'userCart': [],
          'createdAt': Timestamp.now(),
        });

        await userCredential.user!.sendEmailVerification();

        GlobalMethods.verifyAlertDialog(
            title: AppStrings.emailVerification,
            subtitle: AppStrings.emailVerificationSent,
            navigateTo: {
              Navigator.pushReplacementNamed(context, Routes.loginScreenRoute)
            },
            context: context,
            isTWoButtons: false);

        final logger = Logger();
        logger.i("Successfully signed up");
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

  @override
  void dispose() {
    _nameTextController.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _addressTextController.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }
}

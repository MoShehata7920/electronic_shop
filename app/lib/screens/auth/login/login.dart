import 'package:electronic_shop/resources/firebase_constants.dart';
import 'package:electronic_shop/resources/icons_manager.dart';
import 'package:electronic_shop/resources/routes_manager.dart';
import 'package:electronic_shop/resources/strings_manager.dart';
import 'package:electronic_shop/services/functions.dart';
import 'package:electronic_shop/services/global_methods.dart';
import 'package:electronic_shop/widgets/loading_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import '../../../resources/assets_manager.dart';
import '../../../resources/values_manager.dart';
import '../../../widgets/auth_button.dart';
import '../../../widgets/carousel_widget.dart';
import '../../../widgets/google_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();
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
      body: LoadingManager(
        isLoading: _isLoading,
        child: Stack(
          children: [
            SwiperWidget(
                carouselImages: authBackGrounds,
                isSwiperPaginationActive: false),
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
                      AppStrings.welcomeBack,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: AppSize.s30,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: AppSize.s8,
                    ),
                    Text(
                      AppStrings.signInToContinue,
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
                              textInputAction: TextInputAction.done,
                              onEditingComplete: () {
                                _submitLogin(context);
                              },
                              controller: _passwordTextController,
                              focusNode: _passFocusNode,
                              obscureText: _obscureText,
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
                    Align(
                      alignment: Alignment.topRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, Routes.forgotPasswordScreenRoute);
                        },
                        child: Text(
                          AppStrings.forgotPassword,
                          maxLines: 1,
                          style: const TextStyle(
                              color: Colors.cyan,
                              fontSize: AppSize.s18,
                              decoration: TextDecoration.underline,
                              fontStyle: FontStyle.italic),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    AuthButton(
                      buttonFunction: () {
                        _submitLogin(context);
                      },
                      buttonText: AppStrings.login,
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    const GoogleButton(),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: Colors.white,
                            thickness: AppSize.s2,
                          ),
                        ),
                        const SizedBox(
                          width: AppSize.s5,
                        ),
                        Text(
                          AppStrings.or,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: AppSize.s18,
                              fontWeight: FontWeight.normal),
                        ),
                        const SizedBox(
                          width: AppSize.s5,
                        ),
                        const Expanded(
                          child: Divider(
                            color: Colors.white,
                            thickness: AppSize.s2,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    AuthButton(
                      buttonFunction: () {
                        Navigator.pushReplacementNamed(
                            context, Routes.mainScreenRoute);
                      },
                      buttonText: AppStrings.continueAsGuest,
                      buttonColor: Colors.black,
                    ),
                    const SizedBox(
                      height: AppSize.s10,
                    ),
                    RichText(
                        text: TextSpan(
                            text: AppStrings.donHaveAccount,
                            style: const TextStyle(
                                color: Colors.white, fontSize: AppSize.s18),
                            children: [
                          TextSpan(
                              text: "  ${AppStrings.signUp}",
                              style: const TextStyle(
                                  color: Colors.cyan,
                                  fontSize: AppSize.s18,
                                  fontWeight: FontWeight.w600),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.pushNamed(
                                      context, Routes.signUpScreenRoute);
                                }),
                        ]))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool _isLoading = false;

  void _submitLogin(BuildContext context) async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();
    setState(() {
      _isLoading = true;
    });

    if (isValid) {
      try {
        _formKey.currentState!.save();
        await authInstance.signInWithEmailAndPassword(
            email: _emailTextController.text.toLowerCase().trim(),
            password: _passwordTextController.text.toLowerCase().trim());

        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.pushNamed(context, Routes.mainScreenRoute);
        });

        final logger = Logger();
        logger.i("Successfully Logged In");
      } on FirebaseAuthException catch (error) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          GlobalMethods.errorDialog(
            title: "${error.message}",
            warningIcon: JsonAssets.error,
            context: context,
          );
        });
      } catch (error) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          GlobalMethods.errorDialog(
            title: "$error",
            warningIcon: JsonAssets.error,
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
    _emailTextController.dispose();
    _passwordTextController.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }
}

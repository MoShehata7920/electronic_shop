import 'package:electronic_shop/resources/assets_manager.dart';
import 'package:electronic_shop/resources/firebase_constants.dart';
import 'package:electronic_shop/resources/routes_manager.dart';
import 'package:electronic_shop/services/global_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';
import '../resources/strings_manager.dart';
import '../resources/values_manager.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.cyan,
      child: InkWell(
        onTap: () {
          _googleSignIn(context);
        },
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
            color: Colors.white,
            child: SizedBox(
                width: AppSize.s30,
                height: AppSize.s30,
                child: Lottie.asset(JsonAssets.google)),
          ),
          const SizedBox(
            width: AppSize.s8,
          ),
          Text(
            AppStrings.signInGoogle,
            style: const TextStyle(
                color: Colors.white,
                fontSize: AppSize.s18,
                fontWeight: FontWeight.normal),
          ),
        ]),
      ),
    );
  }

// todo: make sure it work again
  Future<void> _googleSignIn(BuildContext context) async {
    final googleSignIn = GoogleSignIn();
    final googleAccount = await googleSignIn.signIn();

    if (googleAccount != null) {
      final googleAuth = await googleAccount.authentication;

      if (googleAuth.accessToken != null && googleAuth.idToken != null) {
        try {
          await authInstance.signInWithCredential(GoogleAuthProvider.credential(
              idToken: googleAuth.idToken,
              accessToken: googleAuth.accessToken));

          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pushNamed(context, Routes.mainScreenRoute);
          });

          final logger = Logger();
          logger.i("Successfully Logged In");
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
        } finally {}
      }
    }
  }
}

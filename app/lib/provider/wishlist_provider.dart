import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronic_shop/resources/firebase_constants.dart';
import 'package:electronic_shop/services/global_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/wishlist_model.dart';

class WishListProvider with ChangeNotifier {
  final Map<String, WishListModel> _wishedItems = {};

  final userCollection = FirebaseFirestore.instance.collection('users');

  Map<String, WishListModel> get getWishedItems {
    return _wishedItems;
  }

  Future<void> fetchWishList() async {
    final User? user = authInstance.currentUser;

    final DocumentSnapshot userDoc = await userCollection.doc(user!.uid).get();

    final wishListLength = userDoc.get('userWishList').length;

    for (int i = 0; i < wishListLength; i++) {
      _wishedItems.putIfAbsent(
          userDoc.get('userWishList')[i]['productId'],
          () => WishListModel(
                id: userDoc.get('userWishList')[i]['theWishId'],
                productId: userDoc.get('userWishList')[i]['productId'],
              ));
    }
    notifyListeners();
  }

  Future<void> addProductToWished({
    required String productId,
    required BuildContext context,
  }) async {
    final User? user = authInstance.currentUser;

    final uid = user!.uid;
    final theWishId = const Uuid().v4();

    try {
      userCollection.doc(uid).update({
        'userWishList': FieldValue.arrayUnion([
          {
            'theWishId': theWishId,
            'productId': productId,
          }
        ])
      });
    } catch (error) {
      GlobalMethods.errorDialog(title: error.toString(), context: context);
    }
  }

  Future<void> removeProductFromWishList({
    required String theWishId,
    required String productId,
  }) async {
    final User? user = authInstance.currentUser;

    await userCollection.doc(user!.uid).update({
      'userWishList': FieldValue.arrayRemove([
        {
          'theWishId': theWishId,
          'productId': productId,
        }
      ])
    });

    _wishedItems.remove(
      productId,
    );
    notifyListeners();
  }

  Future<void> clearWholeWishList() async {
    final User? user = authInstance.currentUser;

    await userCollection.doc(user!.uid).update({'userWishList': []});

    _wishedItems.clear();
    notifyListeners();
  }

  void clearWishList() {
    _wishedItems.clear();
    notifyListeners();
  }
}

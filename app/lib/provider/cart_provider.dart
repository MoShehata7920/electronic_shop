// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electronic_shop/resources/firebase_constants.dart';
import 'package:electronic_shop/services/global_methods.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/cart_model.dart';

class CartProvider with ChangeNotifier {
  final Map<String, CartModel> _cartItems = {};

  final userCollection = FirebaseFirestore.instance.collection('users');

  Map<String, CartModel> get getCartItems {
    return _cartItems;
  }

  Future<void> fetchCartItems() async {
    final User? user = authInstance.currentUser;

    final DocumentSnapshot userDoc = await userCollection.doc(user!.uid).get();

    final cartLength = userDoc.get('userCart').length;

    for (int i = 0; i < cartLength; i++) {
      _cartItems.putIfAbsent(
          userDoc.get('userCart')[i]['productId'],
          () => CartModel(
              id: userDoc.get('userCart')[i]['cartId'],
              productId: userDoc.get('userCart')[i]['productId'],
              quantity: userDoc.get('userCart')[i]['quantity']));
    }
    notifyListeners();
  }

  Future<void> addToCart({
    required String productId,
    required int quantity,
    required BuildContext context,
  }) async {
    final User? user = authInstance.currentUser;

    final uid = user!.uid;
    final cartId = const Uuid().v4();

    try {
      userCollection.doc(uid).update({
        'userCart': FieldValue.arrayUnion([
          {
            'cartId': cartId,
            'productId': productId,
            'quantity': quantity,
          }
        ])
      });
    } catch (error) {
      GlobalMethods.errorDialog(title: error.toString(), context: context);
    }
  }

  Future<void> increaseQuantityByOne(
      {required String cartId,
      required String productId,
      required int quantity}) async {
    final User? user = authInstance.currentUser;

    final userDocRef = userCollection.doc(user!.uid);
    final userDoc = await userDocRef.get();
    final List<dynamic> userCart = userDoc.get('userCart');

    final updatedUserCart = userCart.map((cartItem) {
      if (cartItem['cartId'] == cartId && cartItem['productId'] == productId) {
        return {
          ...cartItem,
          'quantity': cartItem['quantity'] + 1,
        };
      }
      return cartItem;
    }).toList();

    await userDocRef.update({'userCart': updatedUserCart});

    _cartItems.update(
        productId,
        (value) => CartModel(
            id: value.id, productId: productId, quantity: value.quantity + 1));

    notifyListeners();
  }

  void reduceQuantityByOne(
      {required String cartId,
      required String productId,
      required int quantity}) async {
    final User? user = authInstance.currentUser;

    final userDocRef = userCollection.doc(user!.uid);
    final userDoc = await userDocRef.get();
    final List<dynamic> userCart = userDoc.get('userCart');

    final updatedUserCart = userCart.map((cartItem) {
      if (cartItem['cartId'] == cartId && cartItem['productId'] == productId) {
        return {
          ...cartItem,
          'quantity': cartItem['quantity'] - 1,
        };
      }
      return cartItem;
    }).toList();

    await userDocRef.update({'userCart': updatedUserCart});

    _cartItems.update(
        productId,
        (value) => CartModel(
            id: value.id, productId: productId, quantity: value.quantity - 1));
    notifyListeners();
  }

  Future<void> removeOneItem(
      {required String cartId,
      required String productId,
      required int quantity}) async {
    final User? user = authInstance.currentUser;

    await userCollection.doc(user!.uid).update({
      'userCart': FieldValue.arrayRemove([
        {
          'cartId': cartId,
          'productId': productId,
          'quantity': quantity,
        }
      ])
    });

    _cartItems.remove(
      productId,
    );
    notifyListeners();
  }

  Future<void> clearWholeCart() async {
    final User? user = authInstance.currentUser;

    await userCollection.doc(user!.uid).update({'userCart': []});

    _cartItems.clear();
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}

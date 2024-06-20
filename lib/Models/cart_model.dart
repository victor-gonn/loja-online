// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojaonline2/Models/user_model.dart';
import 'package:lojaonline2/DATA/cart_data.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model {
  bool isLoading = false;

  final UserModel? user;

  List<CartData> product = [];

  String? cupomCode;

  int discountPercent = 0;

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  CartModel({this.user}) {
    _loadCartItems();
    print("LOADCART CHAMADO");
  }

  void updatePrices() {
    notifyListeners();
  }

  void setCupom(String? cupomCode, int discountPercent) {
    this.cupomCode = cupomCode;
    this.discountPercent = discountPercent;
  }

  double getProductsPrice() {
    double price = 0.0;
    for (CartData c in product) {
      if (c.productData != null) {
        price += c.quantity * c.productData!.price!.toDouble();
      }
    }
    return price;
  }

  double getDiscount() {
    return getProductsPrice() * discountPercent / 100;
  }

  double getShipPrice() {
    return 9.99;
  }

  Future<String?> finalOrder() async {
    if (product.isEmpty) {
      return null;
    }

    isLoading = true;
    notifyListeners();

    double productsPrice = getProductsPrice();
    double shipPrice = getShipPrice();
    double discount = getDiscount();

    DocumentReference docRef =
        await FirebaseFirestore.instance.collection('orders').add({
      'clientId': user?.user?.uid,
      'products': product.map((cartProduct) => cartProduct.toMap()).toList(),
      'shipPrice': shipPrice,
      'productPrice': productsPrice,
      'discount': discount,
      'totalPrice': productsPrice - discount + shipPrice,
      'status': 1
    });

   await FirebaseFirestore.instance.collection('users').doc(user?.user?.uid).collection('orders')
    .doc(docRef.id).set({
        'orderId' : docRef.id
    });

    QuerySnapshot query = await FirebaseFirestore.instance.collection('users').doc(user?.user?.uid)
    .collection('cart').get();

    for(DocumentSnapshot doc in query.docs) {
      doc.reference.delete();

      
    }

    product.clear();

      cupomCode = null;
      discountPercent = 0;

      isLoading = false;
       notifyListeners();

       return docRef.id;

  }

  void addCartItem(CartData cartData) {
    product.add(cartData);

    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.user?.uid)
        .collection('cart')
        .add(cartData.toMap())
        .then((doc) {
      cartData.cartId = doc.id;

      print(
          'coleçao id ${FirebaseFirestore.instance.collection('users').doc(user?.user?.uid).get()}');
    });
    notifyListeners();
  }

  void removeCartItem(CartData cartData) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.user?.uid)
        .collection('cart')
        .doc(cartData.cartId)
        .delete();
    product.remove(cartData);
    notifyListeners();
  }

  void decrementProduct(CartData cartData) {
    cartData.quantity = cartData.quantity - 1;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.user?.uid)
        .collection('cart')
        .doc(cartData.cartId)
        .update(cartData.toMap());
    notifyListeners();
  }

  void incrementProduct(CartData cartData) {
    cartData.quantity = cartData.quantity + 1;
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.user?.uid)
        .collection('cart')
        .doc(cartData.cartId)
        .set(cartData.toMap(), SetOptions(merge: true));
    notifyListeners();
  }

  void _loadCartItems() async {
    QuerySnapshot query = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.user?.uid)
        .collection('cart')
        .get();

    product =
        await query.docs.map((doc) => CartData.fromDocument(doc)).toList();

    notifyListeners();
  }
}

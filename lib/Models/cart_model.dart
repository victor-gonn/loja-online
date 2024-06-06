import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojaonline2/Models/user_model.dart';
import 'package:lojaonline2/DATA/cart_data.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model{

  final bool isLoading = false;

 final UserModel? user;

 List<CartData> product = [];

 static CartModel of(BuildContext context) => ScopedModel.of<CartModel>(context);

  CartModel(Object? model, {this.user}) {
    _loadCartItems();
    
  }

  void addCartItem(CartData cartData) {
    product.add(cartData);

    FirebaseFirestore.instance.collection('users').doc(user?.user?.uid).collection('cart')
    .add(cartData.toMap()).then((doc) {
      cartData.cartId = doc.id;
    });
    notifyListeners();

  }

  void removeCartItem(CartData cartData) {
    FirebaseFirestore.instance.collection('users').doc(user?.user?.uid).collection('cart')
    .doc(cartData.cartId).delete();
    product.remove(cartData);
    notifyListeners();
  }

  void decrementProduct(CartData cartData) {
    cartData.quantity--;
    FirebaseFirestore.instance.collection('users').doc(user?.user?.uid).collection('cart')
    .doc(cartData.cartId).update(cartData.toMap());
    notifyListeners();
  }

  void incrementProduct(CartData cartData) {
    cartData.quantity = cartData.quantity! + 1;
    FirebaseFirestore.instance.collection('users').doc(user?.user?.uid).collection('cart')
    .doc(cartData.cartId).set(cartData.toMap(), SetOptions(merge: true));
    notifyListeners();
  }

  void _loadCartItems() async {
    QuerySnapshot query = (await FirebaseFirestore.instance.collection('users').doc(user?.user?.uid)
    .collection('cart').get());

    product = query.docs.map((doc) => CartData.fromDocument(doc)).toList();

    notifyListeners();
  }

}
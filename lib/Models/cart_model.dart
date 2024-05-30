import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojaonline2/Models/user_model.dart';
import 'package:lojaonline2/DATA/cart_data.dart';
import 'package:scoped_model/scoped_model.dart';

class CartModel extends Model{

 final UserModel? user;

 List<CartData> product = [];

 static CartModel of(BuildContext context) => ScopedModel.of<CartModel>(context);

  CartModel(Object? model, {this.user});

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

}
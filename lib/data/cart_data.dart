import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:lojaonline2/data/products_data.dart';

class CartData {
  late String cartId;
  late String category;
  late String productId;
  late int quantity;
  late String size;

  late ProductData productData;

  CartData.DocumentSnapshot(DocumentSnapshot snapshot) {
    cartId = snapshot.id;
    category = snapshot.get('category');
    productId = snapshot.get('productId');
    quantity = snapshot.get('quantity');
    size = snapshot.get('size');
    
  }

  Map<String, dynamic> toMap() {
    return {
      'category' : category,
      'productId' : productId,
      'quantity' : quantity,
      'size' : size,
      'product' : productData.toResumeMap()
    };
  }
}
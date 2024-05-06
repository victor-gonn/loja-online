import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {

  late String id;
  late String title;
  late int price;
  late List images;
  late List size;


  ProductData.DocumentSnapshot(DocumentSnapshot snapshot) {
    id = snapshot.id;
    title = snapshot.get('title');
    price = snapshot.get('price');
    images = snapshot.get('images');
    size = snapshot.get('size');

  }

}
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {

  late String id;
  late String title;
  late int price;
  late List images;
  late List size;
  late String description;


  ProductData.DocumentSnapshot(DocumentSnapshot snapshot) {
    id = snapshot.id;
    title = snapshot.get('title');
    price = snapshot.get('price');
    images = snapshot.get('images');
    size = snapshot.get('size');
    description = snapshot.get('description');

  }

  Map<String, dynamic> toResumeMap() {
    return {
      'title' : title,
      'description' : description,
      'price' : price 
    };
  }

}
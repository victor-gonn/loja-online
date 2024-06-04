import 'package:cloud_firestore/cloud_firestore.dart';

class ProductData {

   String? category;
   String? id;
   String? title;
   int? price;
   List? images;
   List? size;
   String? description;


  ProductData.fromDocument(DocumentSnapshot snapshot) {
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
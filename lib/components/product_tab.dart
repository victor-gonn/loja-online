import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojaonline2/components/categore_tile.dart';

class ProductsTab extends StatelessWidget {
  const ProductsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection('products').get(), 
      builder: (context, snapshot){
        if(!snapshot.hasData) {
          return CircularProgressIndicator();
        } 
        else {

          var divideTile = ListTile.divideTiles(
            tiles: snapshot.data!.docs.map((e) {
                return CategoreTile(snapshot: e,
                );
              }).toList(),
              color: Colors.grey
            ).toList();

          return ListView(
            children: divideTile
              
          );
        }

      });
  }
}
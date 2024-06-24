import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderTile extends StatelessWidget {
  const OrderTile(this.orderId,{super.key});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: StreamBuilder<DocumentSnapshot>(stream: FirebaseFirestore.instance.collection('orders')
        .doc(orderId).snapshots(),
         builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return Column(
              children: [
                Text('Código do pedido: ${snapshot.data!.id}',
                style:  TextStyle(fontWeight: FontWeight.w500),)
              ],
            );
          }
         }),),
    );
  }
}
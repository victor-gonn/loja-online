import 'dart:collection';

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

            int status = snapshot.data?['status'];
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Código do pedido: ${snapshot.data!.id}',
                style:  TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 4,),
                Text(_buildProductsText(snapshot.data!)),
                SizedBox(height: 4,),
                Text('Status do pedido:',
                style:  TextStyle(fontWeight: FontWeight.w500),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildStatus('1', 'Preparação', status, 1),
                    Container(width: 40, height: 1, color: Colors.grey,),
                    _buildStatus('2', 'Transporte', status, 2),
                    Container(width: 40, height: 1, color: Colors.grey,),
                    _buildStatus('3', 'Entrega', status, 3)
                  ],
                )
                
              ],
            );
          }
         }),),
    );
  }

  String _buildProductsText(DocumentSnapshot snapshot) {
    String text = 'Descrição:\n';
   
      for(LinkedHashMap p in snapshot['products']) {
      text += '${p['quantity']} x ${p['product'] ['price']} \n';
    
    }
    text += 'Total: R\$ ${snapshot['totalPrice']}';
    return text;
    
  }

  Widget _buildStatus(String title, String subtitle, int status, int thisStatus) {
    Widget child;
    Color backColor;

    if(status < thisStatus) {
      backColor = Colors.grey;
      child = Text(title, style: TextStyle(color: Colors.white),);
    } else if( status == thisStatus) {
      backColor = Colors.blue;
      child = Text(title, style: TextStyle(color: Colors.white),);
    } else {
      backColor = Colors.green;
      child = Icon(Icons.check, color: Colors.white,);
    }

    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: backColor,
          child: child,
        ),
        Text(subtitle)
      ],
    );

  }
}
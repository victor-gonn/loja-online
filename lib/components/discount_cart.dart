// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojaonline2/Models/cart_model.dart';

class DiscountCart extends StatefulWidget {
  const DiscountCart({super.key});

  @override
  State<DiscountCart> createState() => _DiscountCartState();
}

class _DiscountCartState extends State<DiscountCart> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        title: Text(
          'Cupom de desconto',
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
        ),
        leading: Icon(Icons.card_giftcard),
        trailing: Icon(Icons.add),
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Digite seu cupom',

              ),
              initialValue:  CartModel.of(context).cupomCode ?? '' ,
              onFieldSubmitted: (text) {
                FirebaseFirestore.instance.collection('cupons').doc(text).get()
                .then((docSnap) {
                  if(docSnap.data() != null) {
                    CartModel.of(context).setCupom(text, docSnap.get('percent'));
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Desconto de ${docSnap.get('percent')}% aplicado'))
                    );
                  } else { CartModel.of(context).setCupom(null, 0);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Cupom não existente'),
                      backgroundColor: Colors.red,)
                    );
                    

                  }
                });
              },
            ),)
        ],
      ),
      
    );
  }
}

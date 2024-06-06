// ignore_for_file: unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojaonline2/DATA/cart_data.dart';
import 'package:lojaonline2/DATA/products_data.dart';
import 'package:lojaonline2/Models/cart_model.dart';

class CardTile extends StatelessWidget {
  const CardTile( this.cartData ,{super.key });

  final CartData cartData;

  @override
  Widget build(BuildContext context) {

    Widget _buildContent() {
      return Row(
        children: [
          Container(
            width: 120,
            child: Image.network(cartData.productData?.images?[0],
            fit: BoxFit.cover,),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  Text(
                    cartData.productData?.title ?? 'title error',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 17
                    ),
                  ),
                  Text('Tamanho ${cartData.productData?.size}',
                  style: TextStyle(fontWeight: FontWeight.w300),),
                  Text('R\$ ${cartData.productData?.price}',
                  style: TextStyle(color: Colors.black,
                  fontWeight: FontWeight.bold),),
                  Row(children: [
                    IconButton(
                      onPressed: cartData.quantity < 1 ? () {
                        CartModel.of(context).decrementProduct(cartData);
                      } : null,
                      icon: Icon(Icons.remove)),
                     Text(cartData.quantity.toString()),
                    IconButton(
                      onPressed: () {
                        CartModel.of(context).incrementProduct(cartData);
                      }, 
                      icon: Icon(Icons.add)),
                    ElevatedButton(onPressed: (){
                      CartModel.of(context).removeCartItem(cartData);
                    }, 
                    child: Text('Remover'),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.grey[500]
                    ),)


                  ],)
                ],
              ),
            ))
        ],
      );
    }
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: cartData.productData == null ? 
      StreamBuilder<DocumentSnapshot>(stream: FirebaseFirestore.instance.collection('products')
      .doc(cartData.category).collection('itens').doc(cartData.productId).snapshots(), 
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          cartData.productData = ProductData.fromDocument(snapshot.data!);
          return _buildContent();
        } else {
          return Container(
            height: 70,
            child: CircularProgressIndicator(),
            alignment: Alignment.center,
          );
        }

      },
      ) : _buildContent()
    );
  }
}
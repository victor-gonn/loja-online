// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lojaonline2/Models/user_model.dart';
import 'package:lojaonline2/components/order_tile.dart';
import 'package:lojaonline2/screens/login_screen.dart';

class OrderTab extends StatelessWidget {
  const OrderTab({super.key});

  @override
  Widget build(BuildContext context) {
   if(UserModel.of(context).isLoggedIn()){
      String uid = UserModel.of(context).user!.uid;

      return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(uid)
        .collection('orders').get(),
         builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else { 
            return ListView(
              children: 
                snapshot.data!.docs.map((doc) => OrderTile(doc.id)).toList()
              ,
            );
          }

         });


   } else {
    return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.remove_shopping_cart,
                    size: 80,
                    color: Colors.black,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    'Faça login para acompanhar seus pedidos',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => LoginScreen()));
                    },
                    child: Text(
                      'Entrar',
                      style: TextStyle(fontSize: 18),
                    ),
                  )
                ],
              ),
            );
   }
  }
}
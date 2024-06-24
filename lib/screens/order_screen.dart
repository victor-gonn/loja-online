import 'package:flutter/material.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen(this.orderId ,{super.key});

  final String orderId; 

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
       title: Text('Pedido Realizado'),
       centerTitle: true,),
       body: Container(
        padding: EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.check,
            color: Colors.blue,
            size: 80,),
            Text('Pedido realizado com sucesso',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 18
            ),),
            Text('Codigo do pedido ${orderId}', style: TextStyle(
              fontSize: 16
            ),)
          ],
        ),
       ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:lojaonline2/Models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Meu Carrinho'),
        actions: [
          Container(
            padding: EdgeInsets.only(right: 8),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(builder: (context, child, model) {
              int p = model.product.length;
              return Text('${p ?? 0} ${p == 1 ? 'item' : 'itens'}',
              style: TextStyle(
                fontSize: 17
              ),);
            },))
        ],
      ),
    );
  }
}
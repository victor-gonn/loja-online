import 'package:flutter/material.dart';
import 'package:lojaonline2/screens/cart_screen.dart';

class CartButton extends StatelessWidget {
  const CartButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) =>CartScreen())
        );
      },
      child: Icon(Icons.shopping_cart, color: Colors.white,),);
  }
}
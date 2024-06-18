import 'package:flutter/material.dart';
import 'package:lojaonline2/Models/cart_model.dart';
import 'package:lojaonline2/Models/user_model.dart';
import 'package:lojaonline2/components/cart_resume.dart';
import 'package:lojaonline2/components/cart_tile.dart';
import 'package:lojaonline2/components/discount_cart.dart';
import 'package:lojaonline2/components/ship_card.dart';
import 'package:lojaonline2/screens/login_screen.dart';
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
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if(model.isLoading && UserModel.of(context).isLoggedIn()) {
            return Center(child: CircularProgressIndicator(),);
          } else if(!UserModel.of(context).isLoggedIn()) {
            return Container(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.remove_shopping_cart, size: 80, color: Colors.black,),
                  SizedBox(height: 16,),
                  Text('Faça login para visualizar seus produtos', 
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,),
                  SizedBox(height: 16,),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) =>LoginScreen())
                      );
                    }, 
                    child: Text('Entrar', style: TextStyle(fontSize: 18),),)
                ],
              ),
            );
          // ignore: prefer_is_empty, unnecessary_null_comparison
          } else if(model.product == null || model.product.length == 0) {
            return Center(
              child: Text('Nenhum produto adicionado', textAlign: TextAlign.center,),);
          } else {
            return ListView(
              children: [
                Column(
                  children: model.product.map((product) {
                    return CardTile(product);
                  }
                  ).toList(),
                ),
                DiscountCart(),
                ShipCard(),
                CartResume((){})
              ],
            );
            
          }
        },),
    );
  }
}
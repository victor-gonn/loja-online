import 'package:flutter/material.dart';
import 'package:lojaonline2/Models/cart_model.dart';
import 'package:scoped_model/scoped_model.dart';

class CartResume extends StatelessWidget {
   CartResume(this.buy, {super.key});

   final VoidCallback buy;
   

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        padding: const EdgeInsets.all(16),
        child:
            ScopedModelDescendant<CartModel>(builder: (context, child, model) {

              double price = model.getProductsPrice();
              double discount = model.getDiscount();
              double ship = model.getShipPrice();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Resumo do pedido",
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 12,
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Subtotal"), Text("R\$ ${price}")],
              ),
              const Divider(),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Desconto"), Text("R\$ ${discount}")],
              ),
              const Divider(),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text("Entrega"), Text("R\$ ${ship}")],
              ),
              const Divider(),
              const SizedBox(
                height: 12,
              ),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Total",
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                  Text(
                    "R\$ ${price + ship - discount}",
                    style: TextStyle(color: Colors.blue),
                  )
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: buy,
                child: const Text(
                  "Finalizar pedido",
                ),
                style:
                    ElevatedButton.styleFrom(foregroundColor: Colors.white, 
                    backgroundColor: Colors.blue),
              )
            ],
          );
        }),
      ),
    );
  }
}

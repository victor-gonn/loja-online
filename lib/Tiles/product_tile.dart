import 'package:flutter/material.dart';
import 'package:lojaonline2/DATA/products_data.dart';
import 'package:lojaonline2/screens/product_screen.dart';

class ProductTile extends StatelessWidget {
  const ProductTile(this.type, this.product, {super.key});

  final String type;
  final ProductData product;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) =>ProductScreen(product: product,))
        );
      },
      child: Card(
        child: type == 'grid'
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AspectRatio(
                    aspectRatio: 0.815,
                    child: Image.network(
                      product.images?[0],
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Text(product.title!,
                          style: TextStyle(
                            fontWeight: FontWeight.w500
                          ),),
                          Text(
                            'R\$ ${product.price?.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 17,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ), )
                ],
              )
            : Row(
              children: [
                Flexible(flex: 1,
                  child: Image.network(
                    product.images?[0],
                      fit: BoxFit.cover,
                      height: 200,
                  )),
                  Flexible(flex: 1,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.title!,
                          style: TextStyle(
                            fontWeight: FontWeight.w500
                          ),),
                          Text(
                            'R\$ ${product.price?.toStringAsFixed(2)}',
                            style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 17,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ))
              ],
            ),
      ),
    );
  }
}

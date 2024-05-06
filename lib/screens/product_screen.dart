import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lojaonline2/components/products_data.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.product});

  final ProductData product;

  @override
  State<ProductScreen> createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData product;

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 0.9,
            child: CarouselSlider(
                items: product.images.map((url) {
                  return Image.network(url);
                }).toList(),
                options: CarouselOptions(
                    autoPlay: false,
                    enableInfiniteScroll: false,
                    disableCenter: true)),
          ),
          Padding(padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(product.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500
              ),
              maxLines: 3,),
              Text('R\$ ${product.price}',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
              ),)
            ],
          ),)
        ],
      ),
    );
  }
}

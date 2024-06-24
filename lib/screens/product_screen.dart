import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lojaonline2/Models/cart_model.dart';
import 'package:lojaonline2/Models/user_model.dart';
import 'package:lojaonline2/DATA/cart_data.dart';
import 'package:lojaonline2/DATA/products_data.dart';
import 'package:lojaonline2/components/cart_buttom.dart';
import 'package:lojaonline2/screens/login_screen.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key, required this.product});

  final ProductData product;
  

  @override
  // ignore: no_logic_in_create_state
  State<ProductScreen> createState() => _ProductScreenState(product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData product;

   String? size;

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title!),
        centerTitle: true,
      ),
      floatingActionButton: CartButton(),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 0.9,
            child: CarouselSlider(
                items: product.images?.map((url) {
                  return Image.network(url);
                }).toList(),
                options: CarouselOptions(
                    autoPlay: false,
                    enableInfiniteScroll: false,
                    disableCenter: true)),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  product.title!,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  maxLines: 3,
                ),
                Text(
                  'R\$ ${product.price}',
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text("Tamanho",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),),
                SizedBox(
                  height: 34,
                  child: GridView(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    scrollDirection: Axis.horizontal,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      mainAxisSpacing: 8,
                      childAspectRatio: 0.5,
                      
                    ),
                    children: 
                      product.size!.map((s) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              size = s;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              border: Border.all(
                                color: s == size ? Colors.blue : Colors.grey,
                                width: 3
                              )
                            ),
                            width: 50,
                            alignment: Alignment.center,
                            child: Text(s,
                            style: TextStyle(
                              fontWeight: FontWeight.bold
                            ),),
                          ),
                        );
                      }).toList(),
                    ),
                    ),
                    SizedBox(height: 16,),
                    SizedBox(height: 44,
                    child: ElevatedButton(onPressed: size != null ? 
                    () {
                      if(UserModel.of(context).isLoggedIn()) {

                        CartData cartData = CartData();
                        cartData.size = size!;
                        cartData.quantity = 1;
                        cartData.productId = product.id!;
                        cartData.category = product.category!;
                        cartData.productData = product;

                        CartModel.of(context).addCartItem(cartData, );
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => LoginScreen())
                        );
                      }
                    } : null,
                     child: Text(UserModel.of(context).isLoggedIn() ?'adicionar ao carrinho'
                      : 'Faça login para comprar')),),
                     SizedBox(
                      height: 16,
                     ),
                     Text("Descrição",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500
                ),),
                Text(product.description!,
                style: TextStyle(fontSize: 16),)
              ],
            ),
          )
        ],
      ),
    );
  }
}

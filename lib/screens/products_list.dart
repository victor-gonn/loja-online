import 'package:flutter/material.dart';
import 'package:lojaonline2/components/cart_buttom.dart';
import 'package:lojaonline2/components/orders_tab.dart';
import 'package:lojaonline2/screens/drawer.dart';
import 'package:lojaonline2/screens/home_tab.dart';
import 'package:lojaonline2/components/product_tab.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: [
       Scaffold(
        body: InitTab(),
        drawer: CustomDrawer(pageController: _pageController,),
        floatingActionButton: CartButton(),
       ),
       Scaffold(
        appBar: AppBar(
          title: Text("Produtos"),
          centerTitle: true,
        ),
        drawer: CustomDrawer(pageController: _pageController),
        body: ProductsTab(),
        floatingActionButton: CartButton(),
       ),
       Scaffold(
        appBar: AppBar(
          title: Text("Meus pedidos"),
          centerTitle: true,
          ),
          body: OrderTab(),
          drawer: CustomDrawer(pageController: _pageController),),
          
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:lojaonline2/components/cart_buttom.dart';
import 'package:lojaonline2/Tabs/orders_tab.dart';
import 'package:lojaonline2/components/drawer.dart';
import 'package:lojaonline2/screens/home_screen.dart';
import 'package:lojaonline2/Tabs/product_tab.dart';

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
          title: Text("Produtos", style: Theme.of(context).textTheme.titleMedium),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        drawer: CustomDrawer(pageController: _pageController),
        body: ProductsTab(),
        floatingActionButton: CartButton(),
       ),
       Scaffold(
        appBar: AppBar(
          title: Text("Meus pedidos"),
          centerTitle: true,
          backgroundColor: Theme.of(context).primaryColor,
          ),
          body: OrderTab(),
          drawer: CustomDrawer(pageController: _pageController),),
          
      ],
    );
  }
}
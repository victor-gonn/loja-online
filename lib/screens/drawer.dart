// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lojaonline2/Models/user_model.dart';
import 'package:lojaonline2/components/drawer_tile.dart';
import 'package:lojaonline2/screens/login_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key, required this.pageController});

  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    Widget _buildDrawerBack() => Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(colors: const [
            Color.fromARGB(255, 203, 216, 241),
            Colors.white
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
        );

    return Drawer(
      child: Stack(
        children: [
          _buildDrawerBack(),
          ListView(
            padding: EdgeInsets.only(left: 32, top: 20),
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 8),
                padding: EdgeInsets.fromLTRB(0, 16, 16, 0),
                height: 170,
                child: Stack(
                  children: [
                    Positioned(
                      top: 8,
                      left: 0,
                      child: Text(
                        "Loja \nFlutter",
                        style: TextStyle(
                            fontSize: 34, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Positioned(
                        left: 0,
                        bottom: 0,
                        child: ScopedModelDescendant<UserModel>(
                            builder: (context, child, model) {
                          print("model is logged: ${model.isLoggedIn()}");
                          return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Olá, ${!model.isLoggedIn() ? "" : model.userData['name']}",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                                GestureDetector(
                                  child: Text(
                                    !model.isLoggedIn()
                                        ? "Entre ou cadastre-se"
                                        : "Sair",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  onTap: () {
                                    if (!model.isLoggedIn()) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  LoginScreen()));
                                    } else {
                                      model.signOut();
                                      Navigator.of(context).pop();
                                    }
                                  },
                                )
                              ]);
                        }))
                  ],
                ),
              ),
              Divider(),
              DrawerTile(
                icon: Icons.home,
                text: "Início",
                controller: pageController,
                page: 0,
              ),
              DrawerTile(
                  icon: Icons.list,
                  text: "Produtos",
                  controller: pageController,
                  page: 1),
              DrawerTile(
                  icon: Icons.location_on,
                  text: "Loja",
                  controller: pageController,
                  page: 2),
              DrawerTile(
                  icon: Icons.playlist_add_check,
                  text: "Meus Pedidos",
                  controller: pageController,
                  page: 3),
            ],
          )
        ],
      ),
    );
  }
}

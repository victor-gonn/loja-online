// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lojaonline2/components/drawer_tile.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

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
                    Positioned(top: 8,
                    left: 0,child: Text("Loja \nFlutter",
                    style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),),),
                    
                    Positioned(left: 0,
                    bottom: 0,child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text("Olá,",
                      style: TextStyle(fontSize: 18,
                      fontWeight: FontWeight.bold),
                      ),
                      GestureDetector(
                        child: Text("Entre ou cadastre-se", 
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                           ),),
                           onTap: () {},
                      )
                      
                      ]
                    ),
                    )
                  ],
                ),
              ),
              Divider(),
              DrawerTile(icon: Icons.home, text: "Início",),
              DrawerTile(icon: Icons.list, text: "Produtos",),
              DrawerTile(icon: Icons.location_on, text: "Loja",),
              DrawerTile(icon: Icons.playlist_add_check, text: "Meus Pedidos",),
            ],
          )
        ],
      ),
    );
  }
}
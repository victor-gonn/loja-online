import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:lojaonline2/Tiles/product_tile.dart';
import 'package:lojaonline2/DATA/products_data.dart';

class CategoryTab extends StatelessWidget {
  const CategoryTab({super.key, required this.snapshot});

  final DocumentSnapshot snapshot;

 

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: 
          Scaffold(
            
          
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text(
              snapshot.get('title'),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            centerTitle: true,
            bottom: const TabBar(
              indicatorColor: Colors.white,
              tabs: [
                Tab(
                  icon: Icon(Icons.grid_on),
                ),
                Tab(
                  icon: Icon(Icons.list),
                )
              ],
            ),
          ),
          body: FutureBuilder<QuerySnapshot>(future: FirebaseFirestore.instance.collection('products').doc(snapshot.id)
          .collection('itens').get(),
           builder: (context, snapshot) {
            if(!snapshot.hasData) {
              return Center(child: CircularProgressIndicator(),);
            } 
            else{
              return TabBarView(
            children: [ 
              GridView.builder(padding: EdgeInsets.all(4),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                childAspectRatio: 0.65), 
                itemCount: snapshot.data?.docs.length,
              itemBuilder: (context, index){
                ProductData data =  ProductData.fromDocument(snapshot.data!.docs[index]);
                data.category = this.snapshot.id;
                return ProductTile("grid", data);
              }),
              ListView.builder(
                padding: EdgeInsets.all(4),
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index){
                  ProductData data =  ProductData.fromDocument(snapshot.data!.docs[index]);
                data.category = this.snapshot.id;
                return ProductTile("list", data);
              })
            ]);
            }
           })
        ),
        
    
      
    );
  }
}

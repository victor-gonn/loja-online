import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CategoreTile extends StatelessWidget {
  const CategoreTile({super.key, required this.snapshot});

  final DocumentSnapshot snapshot;
  

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundColor: Colors.transparent,
        backgroundImage: NetworkImage(snapshot.get('icon')
  
        ),
        
      ),
      title: Text(snapshot.get('title'),
      ),
      trailing: Icon(Icons.keyboard_arrow_right),
      onTap: (){},
    );
  }
}
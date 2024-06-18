import 'package:flutter/material.dart';

class ShipCard extends StatefulWidget {
  const ShipCard({super.key});

  @override
  State<ShipCard> createState() => _ShipCardState();
}

class _ShipCardState extends State<ShipCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: ExpansionTile(
        title: Text(
          'Calcular frete',
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
        ),
        leading: Icon(Icons.location_on),
        
        children: [
          Padding(
            padding: EdgeInsets.all(8),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Digite seu cupom',

              ),
              initialValue: '' ,
              onFieldSubmitted: (text) {
                
              },
            ),)
        ],
      ),
      
    );
  }
}
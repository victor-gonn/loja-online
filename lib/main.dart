import 'package:flutter/material.dart';
import 'package:lojaonline2/Models/cart_model.dart';
import 'package:lojaonline2/Models/user_model.dart';
import 'package:lojaonline2/components/theme.dart';

import 'package:lojaonline2/screens/products_list.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:scoped_model/scoped_model.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return ScopedModel<CartModel>(
        model: CartModel(user: model), 
        child: MaterialApp(
        home: HomeScreen(),
        theme: theme(),
        debugShowCheckedModeBanner: false,
      ),);
        })
    );
  }
}

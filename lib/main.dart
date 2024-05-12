import 'package:flutter/material.dart';
import 'package:lojaonline2/components/theme.dart';

import 'package:lojaonline2/screens/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lojaonline2/screens/login_screen.dart';
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
    return  MaterialApp(
      home: LoginScreen(),
      theme: theme(),
      debugShowCheckedModeBanner: false,
    );
  }
}

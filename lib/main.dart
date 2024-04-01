import 'package:flutter/material.dart';
import 'package:lojaonline2/components/theme';
import 'package:lojaonline2/screens/home_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: HomeScreen(),
      theme: theme(),
      debugShowCheckedModeBanner: false,
    );
  }
}

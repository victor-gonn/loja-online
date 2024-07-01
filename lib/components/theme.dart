import 'package:flutter/material.dart';

ThemeData theme() {
  

  return ThemeData(
    useMaterial3: true,
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey,
    ),
    
    primaryColor: Color.fromARGB(255, 182, 203, 243),
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.white10,
      primary: Color.fromARGB(255, 211, 115, 130),
      secondary: Color.fromARGB(255, 253, 181, 168),
      tertiary: Colors.green ),
      
      textTheme: TextTheme(
        titleMedium: TextStyle(fontWeight: FontWeight.w400,
        fontSize: 24, color: Colors.white),
        
      )
  );
} 
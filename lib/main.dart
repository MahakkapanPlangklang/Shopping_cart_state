import 'package:flutter/material.dart';
import 'shopping_cart_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blueAccent,
        scaffoldBackgroundColor: Colors.black87,
        fontFamily: 'Roboto',
      ),
      home: ShoppingCartScreen(),
    );
  }
}

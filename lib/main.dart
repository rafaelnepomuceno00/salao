import 'package:flutter/material.dart';
import 'package:salao/screens/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Salão Marina',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        primaryColor: Colors.pinkAccent
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
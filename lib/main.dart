import 'package:flutter/material.dart';
import 'package:lot_recommendation/HomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Maksimal Lot Saham',
      home: HomePage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:food_order_history/food_order_history_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Order App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OrderHistoryPage(),
    );
  }
}

import 'package:flutter/material.dart';
import 'choose.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Payment Gateway App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PaymentSelectionPage(),
    );
  }
}

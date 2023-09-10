import 'package:flutter/material.dart';
import 'shopping_payment.dart'; // Import the new Dart file

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
      home: ShoppingPaymentPage(), // Navigate to the new page
    );
  }
}

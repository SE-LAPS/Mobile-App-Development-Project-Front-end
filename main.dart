import 'package:flutter/material.dart';
import 'debit_card_form.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Debit Card Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DebitCardFormPage(),
    );
  }
}

class SafeAreaExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Safe Area Example'),
      ),
      body: SafeArea(
        child: Center(
          child: Text(
            'Content goes here',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}

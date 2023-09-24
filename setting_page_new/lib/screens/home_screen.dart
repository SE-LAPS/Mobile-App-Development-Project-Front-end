import 'package:flutter/material.dart';
// Replace with actual imports

class HomeScreen extends StatelessWidget {
  final Function(Locale) changeLanguage;

  HomeScreen({required this.changeLanguage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => changeLanguage(Locale('en')),
              child: Text('English'),
            ),
            ElevatedButton(
              onPressed: () => changeLanguage(Locale('si')),
              child: Text('සිංහල'),
            ),
            ElevatedButton(
              onPressed: () => changeLanguage(Locale('ta')),
              child: Text('தமிழ்'),
            ),
          ],
        ),
      ),
    );
  }
}

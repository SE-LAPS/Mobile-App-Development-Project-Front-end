import 'package:flutter/material.dart';
import '../../../core/palette.dart';

class LocationMap extends StatelessWidget {
  static const String routeName = '/locationMap';

  const LocationMap({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: blackColorShade1,
            size: 35,
          ),
        ),
        title: const Text(
          "Canteen Locations",
          style: TextStyle(color: blackColorShade1, fontSize: 25),
        ),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
          
          ),
          Container(
            width: 450, // Adjust the width as needed
            height: 620, // Adjust the height as needed
            child: Image.asset(
              'assets/images/NSBM.png', // Replace with your image path
              fit: BoxFit.contain, // Adjust the fit as needed
            ),
          ),
        ],
      ),
    );
  }
}

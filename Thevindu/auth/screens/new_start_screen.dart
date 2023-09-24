import 'package:flutter/material.dart';

import '../../../core/common/custom_button.dart';
import '../../../core/constants/assets_path.dart';
import '../../../core/palette.dart';
import 'onBording_screen.dart';

class NewStartScreen extends StatelessWidget {
  static const routeName = '/splash_screen';
  const NewStartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(logoPath),
            ),
            const SizedBox(height: 20),
            const Text(
              "FoodX App",
              style: TextStyle(
                  color: textColor, fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              "by FlutterFlares",
              style: TextStyle(color: textColor, fontSize: 12),
            ),
            const SizedBox(height: 80),
            CustomButton(
                text: "Get Started",
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const OnBoardingScreen()));
                }),
          ],
        ),
      ),
    );
  }
}

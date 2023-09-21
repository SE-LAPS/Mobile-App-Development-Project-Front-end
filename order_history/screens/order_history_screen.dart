import 'package:flutter/material.dart';

import '../../../core/palette.dart';

import '../../home/widgets/bottom_bar.dart';

class OrderHistory extends StatelessWidget {
  static const String routeName = '/order_history';
  const OrderHistory({super.key});

  void backToHome(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const BottomBar()));
  }

  @override
  Widget build(BuildContext context) {
    //navigation
    void navigateToBackScreen() {
      Navigator.pop(context);
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () => navigateToBackScreen(),
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: blackColorShade1,
              size: 35,
            ),
          ),
          title: const Text(
            "Privacy Policy",
            style: TextStyle(color: blackColorShade1, fontSize: 25),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: blackColorShade2,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

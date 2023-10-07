import 'package:flutter/material.dart';
import '../../../core/palette.dart';
import '../../home/widgets/bottom_bar.dart';

class RateApp extends StatelessWidget {
  static const String routeName = '/rateApp';

  const RateApp({Key? key});

  // Define a function to navigate back to the previous screen
  void backtoHome(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const BottomBar()));
  }

  // Define a function to create colored headings
  Widget coloredHeading(String text) {
    return Container(
      color: Colors.red[100], // Light red color
      padding: EdgeInsets.all(8.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Navigation
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
          "Rate Dine Delish", // Update the title to "Rate Dine Delish"
          style: TextStyle(color: blackColorShade1, fontSize: 25),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              coloredHeading("Rate Your Dining Experience"),
              Text(
                "We appreciate your feedback! Please take a moment to rate your dining experience with Dine Delish.",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              coloredHeading("How to Rate Dine Delish"),
              Text(
                "To rate Dine Delish, follow these steps:\n\n1. Open the Dine Delish app.\n2. Navigate to the 'Rate Us' section in the app settings.\n3. Choose your rating (from 1 to 5 stars) and leave any comments or suggestions if you'd like.\n4. Submit your rating.\n\nYour feedback helps us improve and provide you with the best dining experience!",
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 20),
              coloredHeading("Contact Dine Delish Support"),
              Text(
                "If you encounter any issues, have questions, or want to provide additional feedback, our support team is here to assist you. Reach out to us, and we'll be happy to help!",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

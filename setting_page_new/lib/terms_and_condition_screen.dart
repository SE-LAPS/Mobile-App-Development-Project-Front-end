import 'package:flutter/material.dart';

class TermsConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Terms and Conditions'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '        Terms and Conditions',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  _termsAndConditionsText,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add any action you want here (e.g., navigating to another screen or closing the app).
                  Navigator.pop(context);
                },
                child: Text('Accept'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const String _termsAndConditionsText = '''

Please read these terms carefully before using the app.

1. Users must provide accurate personal and payment information.

2. Users can place food orders through the app's platform.

3. Users can cancel orders within a specified time frame for a refund.

4. Users with allergies should consult the restaurant about ingredients.

5. Users can provide reviews and feedback on restaurants and orders.

6. User data is collected and used according to the app's privacy policy.

By clicking "Accept," you agree to these terms and conditions.

Thank you for using our app!
''';

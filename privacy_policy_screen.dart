import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  final String privacyPolicyText = '''
  
Last updated: [Date]

Welcome to [MAD GEEKS]! This Privacy Policy outlines how we collect, use, and protect your personal information when you use our mobile application and related services. By using our app, you agree to the practices described in this policy.

  1. Information We Collect

  [Explain what types of information you collect, e.g., personal information, device information, etc.]

  2. How We Use Your Information

  [Explain how you use the collected information, e.g., to improve the App, provide customer support, etc.]

  3. Disclosure of Your Information

  [Explain if and when you share user information with third parties, e.g., service providers, analytics companies, etc.]

  4. Security of Your Information

  [Explain the measures taken to secure user information, e.g., encryption, access controls, etc.]

  5. Changes to this Privacy Policy

  [Explain how you will notify users of any changes to the Privacy Policy.]

  6. Contact Us

  If you have any questions or suggestions about our Privacy Policy, please contact us at [contact@example.com].

  ''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Privacy Policy'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Text(
          privacyPolicyText,
          style: TextStyle(fontSize: 16.0),
        ),
      ),
    );
  }
}

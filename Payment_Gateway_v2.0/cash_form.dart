import 'package:flutter/material.dart';

class CashCardForm extends StatefulWidget {
  @override
  _CashCardFormState createState() => _CashCardFormState();
}

class _CashCardFormState extends State<CashCardForm> {
  TextEditingController _cardNumberController = TextEditingController();
  TextEditingController _expiryDateController = TextEditingController();
  TextEditingController _cvvController = TextEditingController();

  @override
  void dispose() {
    _cardNumberController.dispose();
    _expiryDateController.dispose();
    _cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          alignment: Alignment.centerRight, // Align content to the right
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    // Process the form data here, e.g., send to payment gateway
                    // TODO: Implement payment processing logic

                    // Clear the form after processing
                    _cardNumberController.clear();
                    _expiryDateController.clear();
                    _cvvController.clear();

                    // Close the bottom sheet after processing
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(
                        255, 243, 58, 33), // Set the desired background color
                  ),
                  child: Text('Pay'),
                ),
              ),
              SizedBox(width: 16.0),
              SizedBox(width: 16.0),
              Container(
                width: 150,
                child: ElevatedButton(
                  onPressed: () {
                    // Go back to the checkout page
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(
                        255, 243, 58, 33), // Set the desired background color
                  ),
                  child: Text('Cancel'),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.0),
        SizedBox(height: 16.0),
      ],
    );
  }
}

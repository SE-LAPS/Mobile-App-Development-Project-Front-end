import 'package:flutter/material.dart';

class DebitCardForm extends StatefulWidget {
  @override
  _DebitCardFormState createState() => _DebitCardFormState();
}

class _DebitCardFormState extends State<DebitCardForm> {
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
        SizedBox(height: 50.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 360,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: _cardNumberController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'XXXX-XXXX-XXXX-XXXX',
                  labelText: 'Card Number',
                  prefixIcon: Icon(Icons.credit_card),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: const Color.fromARGB(255, 238, 238, 238)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: const Color.fromARGB(255, 29, 145, 240)),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        Row(
          children: [
            SizedBox(width: 25.0),
            Container(
              width: 150,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: _expiryDateController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'MM/YY',
                  labelText: 'Expiry Date',
                  prefixIcon: Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
              ),
            ),
            SizedBox(width: 16.0),
            SizedBox(width: 16.0),
            Container(
              width: 120,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextFormField(
                controller: _cvvController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'XXX',
                  labelText: 'CVV',
                  prefixIcon: Icon(Icons.help_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16.0),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.0),
        SizedBox(height: 16.0),
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
                    String cardNumber = _cardNumberController.text;
                    String expiryDate = _expiryDateController.text;
                    String cvv = _cvvController.text;

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

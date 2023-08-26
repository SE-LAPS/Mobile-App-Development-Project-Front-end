import 'package:flutter/material.dart';

class CancellationPage extends StatefulWidget {
  @override
  _CancellationPageState createState() => _CancellationPageState();
}

class _CancellationPageState extends State<CancellationPage> {
  String selectedReason = '';
  TextEditingController otherReasonController = TextEditingController();

  List<String> reasons = [
    "Customer realized they ordered the wrong item.",
    "Ordered item is out of stock.",
    "Problem with payment processing.",
    "Poor customer service experience.",
    "Food quality does not meet expectations.",
    "Technical issues during the order process.",
    "Other",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Cancellation'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Select a reason for cancellation:',
              style: TextStyle(fontSize: 22),
            ),
            SizedBox(height: 38),
            Column(
              children: reasons.map((reason) {
                return ListTile(
                  title: Text(reason),
                  leading: Radio(
                    value: reason,
                    groupValue: selectedReason,
                    onChanged: (value) {
                      setState(() {
                        selectedReason = value!;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
            if (selectedReason == "Other")
              TextFormField(
                controller: otherReasonController,
                decoration: InputDecoration(
                  labelText: 'Other Reason',
                ),
              ),
            SizedBox(height: 55),
            Center(
              // Center the button
              child: ElevatedButton(
                onPressed: () {
                  // Handle cancellation here
                  String cancellationReason = selectedReason == "Other"
                      ? otherReasonController.text
                      : selectedReason;
                  // You can send the cancellation reason to your server or perform any other action.
                  print("Cancellation Reason: $cancellationReason");
                },
                child: Text('Submit Here'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

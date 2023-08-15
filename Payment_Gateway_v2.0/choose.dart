import 'package:flutter/material.dart';
import 'cash_form.dart';
import 'credit_card_form.dart';
import 'debit_card_form.dart';

class PaymentSelectionPage extends StatefulWidget {
  @override
  _PaymentSelectionPageState createState() => _PaymentSelectionPageState();
}

class _PaymentSelectionPageState extends State<PaymentSelectionPage> {
  String? selectedOption;

  void _showFormDialog() {
    if (selectedOption == 'Cash') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CashFormDialog();
        },
      );
    } else if (selectedOption == 'Credit Card') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CreditCardFormDialog();
        },
      );
    } else if (selectedOption == 'Debit Card') {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return DebitCardFormDialog();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Gateway App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PaymentOptionWidget(
              option: 'Cash',
              onOptionSelected: (option) {
                setState(() {
                  selectedOption = option;
                });
              },
            ),
            PaymentOptionWidget(
              option: 'Credit Card',
              onOptionSelected: (option) {
                setState(() {
                  selectedOption = option;
                });
              },
            ),
            PaymentOptionWidget(
              option: 'Debit Card',
              onOptionSelected: (option) {
                setState(() {
                  selectedOption = option;
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (selectedOption != null) {
            _showFormDialog();
          }
        },
        child: Icon(Icons.check),
      ),
    );
  }
}

class PaymentOptionWidget extends StatelessWidget {
  final String option;
  final Function(String) onOptionSelected;

  PaymentOptionWidget({
    required this.option,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onOptionSelected(option);
      },
      child: Column(
        children: [
          Icon(Icons.payment, size: 50),
          SizedBox(height: 10),
          Text(option),
        ],
      ),
    );
  }
}

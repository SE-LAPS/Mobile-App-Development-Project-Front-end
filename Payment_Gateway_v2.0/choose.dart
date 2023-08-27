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
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: CashCardForm(),
          );
        },
      );
    } else if (selectedOption == 'Credit Card') {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: CreditCardForm(),
          );
        },
      );
    } else if (selectedOption == 'Debit Card') {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: DebitCardForm(),
          );
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PaymentOptionWidget(
              option: 'Cash',
              icon: Icons.account_balance_wallet,
              onOptionSelected: (option) {
                setState(() {
                  selectedOption = option;
                });
              },
            ),
            PaymentOptionWidget(
              option: 'Credit Card',
              icon: Icons.credit_card,
              onOptionSelected: (option) {
                setState(() {
                  selectedOption = option;
                });
              },
            ),
            PaymentOptionWidget(
              option: 'Debit Card',
              icon: Icons.savings,
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
  final IconData icon;
  final Function(String) onOptionSelected;

  PaymentOptionWidget({
    required this.option,
    required this.icon,
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
          Icon(icon, size: 50),
          SizedBox(height: 10),
          Text(option),
        ],
      ),
    );
  }
}

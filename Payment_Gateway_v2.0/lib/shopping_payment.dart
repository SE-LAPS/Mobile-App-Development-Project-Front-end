import 'package:flutter/material.dart';
import 'debit_card_form.dart';
import 'credit_card_form.dart';
import 'cash_form.dart';

class Item {
  final String name;
  final double price;
  int quantity;
  final String imageUrl;

  Item(this.name, this.price, this.quantity, this.imageUrl);
}

class ShoppingPaymentPage extends StatefulWidget {
  @override
  _ShoppingPaymentPageState createState() => _ShoppingPaymentPageState();
}

class _ShoppingPaymentPageState extends State<ShoppingPaymentPage> {
  String? selectedOption;
  List<Item> items = [
    Item('Kottu', 350.00, 0, 'assets/item1.png'),
    Item('Fried Rice', 420.00, 0, 'assets/item2.png'),
    Item('Milo Milk Shake', 150.00, 0, 'assets/item3.png'),
    // Add more items here
  ];

  double getTotalPrice() {
    double total = 0;
    for (var item in items) {
      total += item.price * item.quantity;
    }
    return total;
  }

  double getSubtotal() {
    double subtotal = 0;
    for (var item in items) {
      subtotal += item.price * item.quantity;
    }
    return subtotal;
  }

  double getDiscount() {
    // Calculate your discount logic here
    // For example, if you have a fixed discount of 50.00, you can return it.
    return 50.00;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment Gateway App'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index].name),
                  subtitle: Text('\Rs${items[index].price.toStringAsFixed(2)}'),
                  leading: Image.asset(
                    items[index].imageUrl,
                    width: 60,
                    height: 60,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (items[index].quantity > 0) {
                              items[index].quantity--;
                            }
                          });
                        },
                      ),
                      Text(items[index].quantity.toString()),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            items[index].quantity++;
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Subtotal:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\Rs${getSubtotal().toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Discount:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\Rs${getDiscount().toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '\Rs${(getSubtotal() - getDiscount()).toStringAsFixed(2)}',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (selectedOption != null) {
                      _showFormDialog();
                    }
                  },
                  child: Text(
                    'Proceed to Payment',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          Center(
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
                const SizedBox(
                  width: 20,
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
                const SizedBox(
                  width: 20,
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
        ],
      ),
    );
  }

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

import 'package:flutter/material.dart';
import '../../../core/palette.dart';
import '../../home/widgets/bottom_bar.dart';

class OrderHistory extends StatelessWidget {
  static const String routeName = '/orderHistory';

  const OrderHistory({Key? key});

  // Define a function to navigate back to the previous screen
  void backToHome(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const BottomBar()));
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
          "Order History",
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
              // You can add order history details here
              _buildOrderItem("Order #12345", "Date: 2023-10-05", "Total: \Rs:750.00"),
              _buildOrderItem("Order #67890", "Date: 2023-10-06", "Total: \Rs:1250.00"),
              _buildOrderItem("Order #54321", "Date: 2023-10-07", "Total: \Rs:1450.00"),
              _buildOrderItem("Order #54321", "Date: 2023-10-08", "Total: \Rs:1750.00"),
              _buildOrderItem("Order #33494", "Date: 2023-10-09", "Total: \Rs:1650.00"),
              _buildOrderItem("Order #77833", "Date: 2023-10-10", "Total: \Rs:2650.00"),
              _buildOrderItem("Order #23875", "Date: 2023-10-11", "Total: \Rs:5650.00"),
              _buildOrderItem("Order #96432", "Date: 2023-10-12", "Total: \Rs:3750.00"),
              _buildOrderItem("Order #24657", "Date: 2023-10-13", "Total: \Rs:4250.00"),
              _buildOrderItem("Order #24657", "Date: 2023-10-14", "Total: \Rs:2250.00"),
              _buildOrderItem("Order #24657", "Date: 2023-10-15", "Total: \Rs:1250.00"),
              // Add more order history items as needed
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderItem(String orderNumber, String orderDate, String orderTotal) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        title: Text(orderNumber),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(orderDate),
            Text(orderTotal),
          ],
        ),
        onTap: () {
          // Handle order item tap, e.g., navigate to order details screen
        },
      ),
    );
  }
}

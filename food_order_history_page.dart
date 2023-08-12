import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class FoodOrder {
  final String orderName;
  final String orderCode;
  final double price;
  final String orderDate;
  final String Items;
  final String imageUrl;

  FoodOrder({
    required this.orderName,
    required this.orderCode,
    required this.price,
    required this.orderDate,
    required this.Items,
    required this.imageUrl,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Order History',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OrderHistoryPage(),
    );
  }
}

class OrderHistoryPage extends StatelessWidget {
  final List<FoodOrder> orders = [
    FoodOrder(
      orderName: 'Fried Rice',
      orderCode: '#12345',
      price: 400.00,
      orderDate: '2023-08-10',
      Items: '2',
      imageUrl:
          'https://i.pinimg.com/originals/7f/e9/6d/7fe96d3fe06d6fc5d821b00d9661b2a9.png',
    ),
    FoodOrder(
      orderName: 'Pastha',
      orderCode: '#42345',
      price: 440.00,
      orderDate: '2023-08-13',
      Items: '2',
      imageUrl:
          'https://i.pinimg.com/originals/7f/e9/6d/7fe96d3fe06d6fc5d821b00d9661b2a9.png',
    ),
    FoodOrder(
      orderName: 'Parata',
      orderCode: '#52345',
      price: 60.00,
      orderDate: '2023-08-11',
      Items: '4',
      imageUrl:
          'https://i.pinimg.com/originals/7f/e9/6d/7fe96d3fe06d6fc5d821b00d9661b2a9.png',
    ),
    FoodOrder(
      orderName: 'Buriyani Rice',
      orderCode: '#12345',
      price: 550.00,
      orderDate: '2023-08-12',
      Items: '1',
      imageUrl:
          'https://i.pinimg.com/originals/7f/e9/6d/7fe96d3fe06d6fc5d821b00d9661b2a9.png',
    ),
    FoodOrder(
      orderName: 'Milo Juice',
      orderCode: '#32345',
      price: 200.00,
      orderDate: '2023-08-12',
      Items: '2',
      imageUrl:
          'https://i.pinimg.com/originals/7f/e9/6d/7fe96d3fe06d6fc5d821b00d9661b2a9.png',
    ),
    FoodOrder(
      orderName: 'Avacado Juice',
      orderCode: '#32345',
      price: 250.00,
      orderDate: '2023-08-12',
      Items: '1',
      imageUrl:
          'https://i.pinimg.com/originals/7f/e9/6d/7fe96d3fe06d6fc5d821b00d9661b2a9.png',
    ),
    FoodOrder(
      orderName: 'Chocolate Milk Shake',
      orderCode: '#32345',
      price: 400.00,
      orderDate: '2023-08-13',
      Items: '1',
      imageUrl:
          'https://i.pinimg.com/originals/7f/e9/6d/7fe96d3fe06d6fc5d821b00d9661b2a9.png',
    ),

    // Add more orders here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order History'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return ListTile(
            leading: Image.network(order.imageUrl),
            title: Text(order.orderName),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Order Code: ${order.orderCode}'),
                Text('Price: \Rs: ${order.price.toStringAsFixed(2)}'),
                Text('Order Date: ${order.orderDate}'),
                Text('Items: ${order.Items}'),
              ],
            ),
            trailing: ElevatedButton(
              onPressed: () {
                // Reorder functionality goes here
                // You can implement the logic to add the order to the cart or perform any other action
              },
              child: Text('Reorder'),
            ),
          );
        },
      ),
    );
  }
}

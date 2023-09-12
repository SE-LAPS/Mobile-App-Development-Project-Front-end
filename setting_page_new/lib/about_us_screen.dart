import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  // Define a list of restaurant data
  final List<Map<String, String>> restaurants = [
    {
      'name': 'Edge Restaurant',
      'location': 'NSBM Green University',
    },
    {
      'name': 'Hostal Canteen',
      'location': 'NSBM Green University',
    },
    {
      'name': 'Audi Canteen',
      'location': 'NSBM Green University',
    },
    {
      'name': 'Juice Bar',
      'location': 'NSBM Green University',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Us'),
      ),
      body: ListView.builder(
        itemCount: restaurants.length, // Number of restaurants
        itemBuilder: (BuildContext context, int index) {
          return buildRestaurantCard(context, index);
        },
      ),
    );
  }

  Widget buildRestaurantCard(BuildContext context, int index) {
    // Get restaurant data from the list
    String? restaurantName = restaurants[index]['name'];
    String? restaurantLocation = restaurants[index]['location'];

    return Card(
      margin: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Image.asset(
            'assets/restaurant${index + 1}.png', // Replace with actual image paths
            width: double.infinity,
            height: 200.0,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  restaurantName!,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  restaurantLocation!,
                  style: TextStyle(fontSize: 16.0),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    // Handle the "Read More" button click
                    // You can navigate to a detailed restaurant page or show more information here.
                  },
                  child: Text('Read More'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

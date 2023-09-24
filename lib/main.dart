import 'package:flutter/material.dart';
import 'package:search_list/model/food_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SerchPage(),
    );
  }
}

class SerchPage extends StatefulWidget {
  const SerchPage({super.key});

  @override
  State<SerchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SerchPage> {
  static List<FoodModel> main_food_list = [
    FoodModel("Fried Rice", "Edge Restaurant", 500.00,
        "https://media.istockphoto.com/id/1175434591/photo/fried-rice-with-ketchup-and-soy-sauce.jpg?s=170667a&w=0&k=20&c=EJ_up1LdVYn2iRQ8VC43anJzn-U2XtVzXL6Maypdzb8="),
    FoodModel("Kottu", "Edge Restaurant", 550.00,
        "https://www.chariot.lk/content_images/j20211030042719.jpeg"),
    FoodModel("Pastha", "Hostel Canteen", 440.00,
        "https://www.nicepng.com/png/detail/72-723066_macaroni-png-image-with-transparent-background-pasta-png.png"),
    FoodModel("Milk Shake", "Hostel Canteen", 400.00,
        "https://img.taste.com.au/2TWekadq/taste/2016/11/top-10-milkshakes-image-1-64000-1.jpg"),
    FoodModel("Avacado Shake", "Juice Bar", 350.00,
        "https://st.depositphotos.com/1177973/3545/i/450/depositphotos_35450321-stock-photo-fresh-avocado-smoothie-isolated-on.jpg"),
    FoodModel("Chocolate MilkShake", "Audi Canteen", 450.00,
        "https://img.freepik.com/premium-photo/chocolate-drink-based-yogurt-cocoa-white-background_195501-438.jpg"),
    FoodModel("Fried Rice", "Hostel Canteen", 400.00,
        "https://media.istockphoto.com/id/1175434591/photo/fried-rice-with-ketchup-and-soy-sauce.jpg?s=170667a&w=0&k=20&c=EJ_up1LdVYn2iRQ8VC43anJzn-U2XtVzXL6Maypdzb8="),
    FoodModel("Pastha", "Edge Reataurant", 540.00,
        "https://www.nicepng.com/png/detail/72-723066_macaroni-png-image-with-transparent-background-pasta-png.png"),
  ];

  List<FoodModel> display_list = List.from(main_food_list);

  void updateList(String value) {
    setState(() {
      display_list = main_food_list
          .where((element) =>
              element.food_title!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        elevation: 0.0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Saerch Your Favourite Food Item",
              style: TextStyle(
                color: Colors.black,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            TextField(
              onChanged: (value) => updateList(value),
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Color.fromARGB(255, 213, 213, 213),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                hintText: "Fried Rice",
                prefixIcon: Icon(Icons.search),
                prefixIconColor: const Color.fromARGB(255, 6, 1, 12),
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            Expanded(
              child: display_list.length == 0
                  ? Center(
                      child: Text(
                        "Now result found",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: display_list.length,
                      itemBuilder: (context, index) => ListTile(
                        contentPadding: EdgeInsets.all(8.0),
                        title: Text(
                          display_list[index].food_title!,
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        subtitle: Text(
                          '${display_list[index].food_res_name!}',
                          style: TextStyle(
                            color: Colors.black,
                          ),
                        ),
                        trailing: Text(
                          "${display_list[index].rating}",
                          style: TextStyle(
                              color: const Color.fromARGB(255, 255, 73, 7)),
                        ),
                        leading:
                            Image.network(display_list[index].food_poster_url!),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemsWidget extends StatelessWidget {
  const ItemsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      childAspectRatio: 0.78,
      children: [
        for (int i = 1; i < 5; i++)
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 13),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: const Color(0xFF232227),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 1,
                  blurRadius: 8,
                ),
              ],
            ),
            child: Column(children: [
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, "singleItemPage");
                },
                child: Container(
                  margin: const EdgeInsets.all(10),
                  child: Image.asset(
                      "assets/images/$i.png", 
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Fried Rice",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: const Text(
                  "Edge Restaurant",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white60,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Rs:400.00",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Icon(
                      CupertinoIcons.cart_badge_plus,
                      size: 27,
                      color: Colors.white,
                    )
                  ],
                ),
              ),
            ]),
          ),
      ],
    );
  }
}

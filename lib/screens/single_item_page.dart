import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/ingle_item_nav_bar.dart';
//import '../widgets/single_item_nav_bar.dart'; // Update this import as needed

class SingleItemPage extends StatelessWidget {
  const SingleItemPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF232227),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(top: 25, left: 10, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Icon(
                      CupertinoIcons.cart_fill,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ],
              ),
              Padding(
                padding:const EdgeInsets.symmetric(vertical: 10),
                child: Image.asset(
                  "assets/images/6.png",
                  height: MediaQuery.of(context).size.height / 1.7,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:const EdgeInsets.only(right: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Hot & Fresh Burger",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {},
                              child: Container(
                                alignment: Alignment.center,
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child:const Icon(
                                  CupertinoIcons.minus,
                                  size: 20,
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            const Text(
                              "2",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 8),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                alignment: Alignment.center,
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child:const Icon(
                                  CupertinoIcons.plus,
                                  size: 20,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "Good food is not just about taste, and diet is not just about achieving an ideal weight or dress size.",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const SingleItemNavBar(), // Update this line as needed
    );
  }
}

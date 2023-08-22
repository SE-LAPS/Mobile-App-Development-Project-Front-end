import 'package:firebase_auth/firebase_auth.dart';
//import 'package:Dine Delish App/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

import '../widgets/HomeNavBar.dart';
import '../widgets/items_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String? userName = FirebaseAuth.instance.currentUser?.displayName;
   @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor:const Color(0xFF232227),
        body: SafeArea(
          child: Padding(
            padding:const EdgeInsets.only(top: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {},
                        child:const  Icon(
                          Icons.sort_rounded,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child:const  Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 35,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                const Padding (
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "NSBM Food Court",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    "Hot & Fast Food",
                    style: TextStyle(
                      color: Colors.white60,
                      fontSize: 22,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const TabBar(
                  isScrollable: true,
                  labelStyle: TextStyle(fontSize: 20),
                  labelPadding: EdgeInsets.symmetric(horizontal: 20),
                  tabs: [
                    Tab(text: "All Items"),
                    Tab(text: "Food"),
                    Tab(text: "Beverage"),
                    Tab(text: "Cake"),
                  ],
                ),
                const Flexible (
                  flex: 1,
                  child: TabBarView(
                    children: [
                      ItemsWidget(),
                      ItemsWidget(),
                      ItemsWidget(),
                      ItemsWidget(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const HomeNavBar(),
      ),
    );
  }
}
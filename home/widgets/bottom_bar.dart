import 'package:flutter/material.dart';

import '../../../core/palette.dart';
import '../../account/screens/account_screen.dart';
import '../../categories/screens/category_screen.dart';
import '../../favorite/screens/favorite_screen.dart';
import '../../notification/screens/notification_screen.dart';
import '../screens/home_screen.dart';

class BottomBar extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  double bottomBarWidth = 42;
  double bottomBarBorderWidth = 5;

  List<Widget> pages = [
    const HomeScreen(),
    const CategoryScreen(),
    const FavoriteScreen(),
    const NotificationScreen(),
    const AccountScreen(),
  ];

  // List<Widget> pages = [
  //   const Scaffold(
  //     body: Center(child: Text("Page 0")),
  //   ),
  //   const Scaffold(
  //     body: Center(child: Text("Page 1")),
  //   ),
  //   const Scaffold(
  //     body: Center(child: Text("Page 2")),
  //   ),
  //   const Scaffold(
  //     body: Center(child: Text("Page 3")),
  //   ),
  //   Scaffold(
  //     body: Center(
  //       child: Consumer(
  //         builder: (BuildContext context, WidgetRef ref, child) =>
  //             ElevatedButton(
  //                 onPressed: () {
  //                   ref
  //                       .read(accountControllerProvider.notifier)
  //                       .logOut(context);
  //                 },
  //                 child: const Text("SignOut")),
  //       ),
  //     ),
  //   ),
  // ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: pages[_page],
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          currentIndex: _page,
          iconSize: 28,
          onTap: updatePage,
          items: [
            BottomNavigationBarItem(
              icon: SizedBox(
                width: bottomBarWidth,
                child: Icon(
                  Icons.home_outlined,
                  color: _page == 0 ? primaryColor : blackColorShade1,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: bottomBarWidth,
                child: Icon(
                  Icons.category_outlined,
                  color: _page == 1 ? primaryColor : blackColorShade1,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: bottomBarWidth,
                child: Icon(
                  Icons.favorite_outline_rounded,
                  color: _page == 2 ? primaryColor : blackColorShade1,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: bottomBarWidth,
                child: Icon(
                  Icons.notifications_none_rounded,
                  color: _page == 3 ? primaryColor : blackColorShade1,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SizedBox(
                width: bottomBarWidth,
                child: Icon(
                  Icons.person_outline_rounded,
                  color: _page == 4 ? primaryColor : blackColorShade1,
                ),
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}

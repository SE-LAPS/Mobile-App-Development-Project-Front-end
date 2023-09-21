import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/palette.dart';
import '../../home/widgets/bottom_bar.dart';

class NotificationScreen extends ConsumerStatefulWidget {
  const NotificationScreen({super.key});

  @override
  ConsumerState<NotificationScreen> createState() =>
      _NotificationScreenConsumerState();
}

class _NotificationScreenConsumerState
    extends ConsumerState<NotificationScreen> {
  final List<String> images = [];

  void backtoHome() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const BottomBar()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: backtoHome,
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: blackColorShade1,
              size: 35,
            ),
          ),
          title: const Text(
            "Notification",
            style: TextStyle(color: blackColorShade1, fontSize: 25),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: Column(
              children: [
                const ListTile(
                  title: Text(
                    "Today",
                    style: TextStyle(color: blackColorShade1, fontSize: 20),
                  ),
                  trailing: Text(
                    "clear all",
                    style: TextStyle(color: blackColorShade1, fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: blackColorShade2,
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              alignment: Alignment.topRight,
                              padding: const EdgeInsets.all(10.0),
                              child: const Text(
                                "10 min",
                                style: TextStyle(
                                    color: blackColorShade1, fontSize: 10),
                              ),
                            ),
                            ListTile(
                              minLeadingWidth: 50,
                              leading: IconButton(
                                padding: const EdgeInsets.all(0.0),
                                onPressed: () {},
                                icon: const SizedBox(
                                  height: 45,
                                  width: 45,
                                  child: Icon(
                                    Icons.circle_notifications,
                                    size: 45,
                                  ),
                                ),
                              ),
                              title: const Text(
                                "Foods",
                                style: TextStyle(
                                    color: blackColorShade1, fontSize: 20),
                              ),
                              subtitle: const Text(
                                "You set reminder for 22 september 2023",
                                style: TextStyle(
                                    color: blackColorShade1, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: blackColorShade2,
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              alignment: Alignment.topRight,
                              padding: const EdgeInsets.all(10.0),
                              child: const Text(
                                "28 min",
                                style: TextStyle(
                                    color: blackColorShade1, fontSize: 10),
                              ),
                            ),
                            ListTile(
                              minLeadingWidth: 50,
                              leading: IconButton(
                                padding: const EdgeInsets.all(0.0),
                                onPressed: () {},
                                icon: const SizedBox(
                                  height: 45,
                                  width: 45,
                                  child: Icon(
                                    Icons.circle_notifications,
                                    size: 45,
                                  ),
                                ),
                              ),
                              title: const Text(
                                "Soft Drinks",
                                style: TextStyle(
                                    color: blackColorShade1, fontSize: 20),
                              ),
                              subtitle: const Text(
                                "You set reminder for 22 september 2023",
                                style: TextStyle(
                                    color: blackColorShade1, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const ListTile(
                  title: Text(
                    "Yesterday",
                    style: TextStyle(color: blackColorShade1, fontSize: 20),
                  ),
                  trailing: Text(
                    "clear all",
                    style: TextStyle(color: blackColorShade1, fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: blackColorShade2,
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              alignment: Alignment.topRight,
                              padding: const EdgeInsets.all(10.0),
                              child: const Text(
                                "1day & 12 min",
                                style: TextStyle(
                                    color: blackColorShade1, fontSize: 10),
                              ),
                            ),
                            ListTile(
                              minLeadingWidth: 50,
                              leading: IconButton(
                                padding: const EdgeInsets.all(0.0),
                                onPressed: () {},
                                icon: const SizedBox(
                                  height: 45,
                                  width: 45,
                                  child: Icon(
                                    Icons.circle_notifications,
                                    size: 45,
                                  ),
                                ),
                              ),
                              title: const Text(
                                "Ice-Cream",
                                style: TextStyle(
                                    color: blackColorShade1, fontSize: 20),
                              ),
                              subtitle: const Text(
                                "You set reminder for 21 september 2023",
                                style: TextStyle(
                                    color: blackColorShade1, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: blackColorShade2,
                    ),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              alignment: Alignment.topRight,
                              padding: const EdgeInsets.all(10.0),
                              child: const Text(
                                "1 day & 26 min",
                                style: TextStyle(
                                    color: blackColorShade1, fontSize: 10),
                              ),
                            ),
                            ListTile(
                              minLeadingWidth: 50,
                              leading: IconButton(
                                padding: const EdgeInsets.all(0.0),
                                onPressed: () {},
                                icon: const SizedBox(
                                  height: 45,
                                  width: 45,
                                  child: Icon(
                                    Icons.circle_notifications,
                                    size: 45,
                                  ),
                                ),
                              ),
                              title: const Text(
                                "Fresh Juices",
                                style: TextStyle(
                                    color: blackColorShade1, fontSize: 20),
                              ),
                              subtitle: const Text(
                                "you set reminder for you appointment",
                                style: TextStyle(
                                    color: blackColorShade1, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

import 'package:flutter/material.dart';

import '../../../core/palette.dart';
import '../../home/widgets/bottom_bar.dart';
import '../services/user_services.dart';

class TrackOrderScren extends StatefulWidget {
  const TrackOrderScren({super.key});

  @override
  State<TrackOrderScren> createState() => _TrackOrderScrenState();
}

class _TrackOrderScrenState extends State<TrackOrderScren> {
  final List<String> user = [];

  void getUser() async {
    final UserServices userServices = UserServices();
    final List<String> userdata = await userServices.getUser();

    user.addAll(userdata);

    setState(() {
      user;
    });
  }

  @override
  void initState() {
    getUser();
    super.initState();
  }

//navigation
  void navigateToHome(BuildContext context) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (_) => const BottomBar()), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            navigateToHome(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: blackColorShade1,
            size: 35,
          ),
        ),
        title: const Text(
          "Track my Order",
          style: TextStyle(
              color: blackColorShade1,
              fontSize: 25,
              fontWeight: FontWeight.w500),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.04,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.28),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(50),
                    right: Radius.circular(50),
                  ),
                  border: Border.all(color: primaryColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Placed',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(50)),
                      child: const Icon(
                        Icons.check_rounded,
                        weight: 25,
                        color: primaryColor,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 40,
                width: 0,
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 2)),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.28),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(50),
                    right: Radius.circular(50),
                  ),
                  border: Border.all(color: primaryColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Approved',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(50)),
                      child: const Icon(
                        Icons.check_rounded,
                        weight: 25,
                        color: primaryColor,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 40,
                width: 0,
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 2)),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.28),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(50),
                    right: Radius.circular(50),
                  ),
                  border: Border.all(color: primaryColor),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Shipped',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          color: primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(50)),
                      child: const Icon(
                        Icons.check_rounded,
                        weight: 25,
                        color: primaryColor,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 40,
                width: 0,
                decoration: BoxDecoration(
                    border: Border.all(color: primaryColor, width: 2)),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: size.width * 0.28),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.horizontal(
                    left: Radius.circular(50),
                    right: Radius.circular(50),
                  ),
                  border: Border.all(
                    color: blackColorShade1,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      'Delivery',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    Container(
                      height: 70,
                      width: 70,
                      decoration: BoxDecoration(
                          color: blackColorShade1.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(50)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: size.height * 0.16,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.access_time,
                        size: 30,
                        color: primaryColor,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '11 : 00 am',
                            style: TextStyle(fontSize: 22),
                          ),
                          Text(
                            ' Delivery Time',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      )
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.location_on_outlined,
                        size: 30,
                        color: primaryColor,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Gilgit City',
                            style: TextStyle(fontSize: 22),
                          ),
                          Text(
                            'Delivery Place',
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              const Divider(thickness: 2),
              const SizedBox(
                height: 15,
              ),
              user.length != 0
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 80,
                          width: 80,
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage: NetworkImage(user[2]),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user[0],
                              style: const TextStyle(
                                  color: blackColorShade1, fontSize: 23),
                            ),
                            const Text(
                              "Delivery Agent",
                              style: TextStyle(
                                  color: blackColorShade1, fontSize: 15),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: size.width * 0.12,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.messenger_rounded),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.phone_rounded),
                        ),
                      ],
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}

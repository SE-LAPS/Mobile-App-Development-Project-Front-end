import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/constants.dart';
import '../../../core/palette.dart';
import '../../address/screens/address_screen.dart';
import '../../auth/controller/auth_controller.dart';
import '../../home/widgets/bottom_bar.dart';
import '../../privacyPolicy/screens/privacy_policy_scree.dart';
import '../controller/account_controller.dart';
import '../widget/logOut_confirmation.dart';

class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  void backtoHome(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const BottomBar()));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    //navigation
    void navigateToAddressScreen() {
      Navigator.pushNamed(context, AddressScreen.routeName);
    }

    void navigateToPrivacyPolicyScreen() {
      Navigator.pushNamed(context, PrivacyPolicy.routeName);
    }

    //logOut
    void logOut() {
      ref.read(accountControllerProvider.notifier).logOut(context);
    }

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            onPressed: () => backtoHome(context),
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: blackColorShade1,
              size: 35,
            ),
          ),
          title: const Text(
            "My Account",
            style: TextStyle(color: blackColorShade1, fontSize: 25),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                user != null
                    ? Row(
                        children: [
                          SizedBox(
                            height: 80,
                            width: 80,
                            child: CircleAvatar(
                              radius: 80,
                              backgroundImage: NetworkImage(
                                  user!.photoUrl.isEmpty
                                      ? Constants.avatarDefault
                                      : user.photoUrl),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name,
                                style: const TextStyle(
                                    color: blackColorShade1, fontSize: 23),
                              ),
                              Text(
                                user.email,
                                style: const TextStyle(
                                    color: blackColorShade1, fontSize: 15),
                              ),
                            ],
                          ),
                        ],
                      )
                    : SizedBox(),
                const SizedBox(
                  height: 65,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: blackColorShade2,
                  ),
                  child: ListTile(
                    onTap: navigateToAddressScreen,
                    minLeadingWidth: 50,
                    leading: IconButton(
                      padding: const EdgeInsets.all(0.0),
                      onPressed: () {},
                      icon: const SizedBox(
                        height: 30,
                        width: 30,
                        child: Icon(
                          Icons.person,
                          color: primaryColor,
                          size: 30,
                        ),
                      ),
                    ),
                    title: const Text(
                      "Edit Profile",
                      style: TextStyle(color: blackColorShade1, fontSize: 15),
                    ),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward_ios_rounded)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: blackColorShade2,
                  ),
                  child: ListTile(
                    minLeadingWidth: 50,
                    leading: IconButton(
                      padding: const EdgeInsets.all(0.0),
                      onPressed: () {},
                      icon: const SizedBox(
                        height: 30,
                        width: 30,
                        child: Icon(
                          Icons.access_time,
                          color: primaryColor,
                          size: 30,
                        ),
                      ),
                    ),
                    title: const Text(
                      "Order History",
                      style: TextStyle(color: blackColorShade1, fontSize: 15),
                    ),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward_ios_rounded)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: blackColorShade2,
                  ),
                  child: ListTile(
                    onTap: navigateToPrivacyPolicyScreen,
                    minLeadingWidth: 50,
                    leading: IconButton(
                      padding: const EdgeInsets.all(0.0),
                      onPressed: () {},
                      icon: const SizedBox(
                        height: 30,
                        width: 30,
                        child: Icon(
                          Icons.privacy_tip_outlined,
                          color: primaryColor,
                          size: 30,
                        ),
                      ),
                    ),
                    title: const Text(
                      "Privacy Policy",
                      style: TextStyle(color: blackColorShade1, fontSize: 15),
                    ),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward_ios_rounded)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: blackColorShade2,
                  ),
                  child: ListTile(
                    minLeadingWidth: 50,
                    leading: IconButton(
                      padding: const EdgeInsets.all(0.0),
                      onPressed: () {},
                      icon: const SizedBox(
                        height: 30,
                        width: 30,
                        child: Icon(
                          Icons.help_outline,
                          color: primaryColor,
                          size: 30,
                        ),
                      ),
                    ),
                    title: const Text(
                      "Help",
                      style: TextStyle(color: blackColorShade1, fontSize: 15),
                    ),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward_ios_rounded)),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: blackColorShade2,
                  ),
                  child: ListTile(
                    minLeadingWidth: 50,
                    leading: IconButton(
                      padding: const EdgeInsets.all(0.0),
                      onPressed: () {},
                      icon: const SizedBox(
                        height: 30,
                        width: 30,
                        child: Icon(
                          Icons.star_border_rounded,
                          color: primaryColor,
                          size: 30,
                        ),
                      ),
                    ),
                    title: const Text(
                      "Rate Our App",
                      style: TextStyle(color: blackColorShade1, fontSize: 15),
                    ),
                    trailing: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.arrow_forward_ios_rounded)),
                  ),
                ),
                const SizedBox(
                  height: 60,
                ),
                InkWell(
                  onTap: () => logOutConfirmationDialog(
                    context: context,
                    onConfirm: () => logOut(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.logout_outlined,
                        size: 25,
                      ),
                      Text(
                        "Log out",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}

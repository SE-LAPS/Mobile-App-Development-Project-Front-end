import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  // ignore: use_key_in_widget_constructors
  const NavBar({Key? key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('TRS Rathnayaka'),
            accountEmail: const Text('Ranu@gmail.com'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  'https://oflutter.com/wp-content/uploads/2021/02/girl-profile.png',
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(
                  'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg',
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Home'),
            onTap: () {
              // Implement the action for Home
            },
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: const Text('Favourite'),
            onTap: () {
              // Implement the action for Favourite
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('My Profile'),
            onTap: () {
              // Implement the action for My Profile
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notification'),
            onTap: () {
              // Implement the action for Notification
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings'),
            onTap: () {
              // Implement the action for Settings
            },
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Helps'),
            onTap: () {
              // Implement the action for Helps
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Log out'),
            leading: const Icon(Icons.exit_to_app),
            onTap: () {
              // Implement the action for Log out
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:settingpage/about_us_screen.dart';

import 'package:settingpage/privacy_policy_screen.dart';
import 'package:settingpage/screens/home_screen.dart';
import 'package:settingpage/terms_and_condition_screen.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool _notificationEnabled = true;
  bool _darkModeEnabled = false;
  bool _orderUpdatesEnabled = true;

  void _toggleNotification(bool value) {
    setState(() {
      _notificationEnabled = value;
    });
  }

  void _toggleDarkMode(bool value) {
    setState(() {
      _darkModeEnabled = value;
    });
  }

  void _toggleOrderUpdates(bool value) {
    setState(() {
      _orderUpdatesEnabled = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.settings),
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          const ListTile(
            title: Text('Personal Account'),
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            trailing: Switch(
              value: _notificationEnabled,
              onChanged: _toggleNotification,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.lightbulb),
            title: const Text('Dark Mode'),
            onTap: () {},
            trailing: Switch(
              value: _darkModeEnabled,
              onChanged: _toggleDarkMode,
            ),
          ),
          ListTile(
            leading: const Icon(Icons.library_books),
            title: const Text('Order Updates'),
            trailing: Switch(
              value: _orderUpdatesEnabled,
              onChanged: _toggleOrderUpdates,
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.language_outlined),
            title: const Text('Language'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => HomeScreen(
                          changeLanguage: (Locale) {},
                        )),
              );
            },
          ),
          ListTile(
            title: const Text('More Information'),
            onTap: () {
              // TODO: Navigate to About Us page
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('About Us'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AboutUsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.lock),
            title: const Text('Privacy and Policy'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PrivacyPolicyScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.library_books),
            title: const Text('Terms and Conditions'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TermsConditionsScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sign Out'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

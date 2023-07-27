import 'package:flutter/material.dart';

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
        leading: Icon(Icons.settings),
        title: Text('Settings'),
      ),
      body: ListView(
        children: [
          ListTile(
            title: Text('Personal Account'),
          ),
          ListTile(
            leading: Icon(Icons.notifications),
            title: Text('Notifications'),
            trailing: Switch(
              value: _notificationEnabled,
              onChanged: _toggleNotification,
            ),
          ),
          ListTile(
            leading: Icon(Icons.lightbulb),
            title: Text('Dark Mode'),
            trailing: Switch(
              value: _darkModeEnabled,
              onChanged: _toggleDarkMode,
            ),
          ),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text('Order Updates'),
            trailing: Switch(
              value: _orderUpdatesEnabled,
              onChanged: _toggleOrderUpdates,
            ),
          ),
          ListTile(
            leading: Icon(Icons.language_outlined),
            title: Text('Language'),
            onTap: () {
              // TODO: Navigate to language page
            },
          ),
          ListTile(
            title: Text('More Information'),
            onTap: () {
              // TODO: Navigate to About Us page
            },
          ),
          ListTile(
            leading: Icon(Icons.info),
            title: Text('About Us'),
            onTap: () {
              // TODO: Navigate to About Us page
            },
          ),
          ListTile(
            leading: Icon(Icons.lock),
            title: Text('Privacy and Policy'),
            onTap: () {
              // TODO: Navigate to Privacy and Policy page
            },
          ),
          ListTile(
            leading: Icon(Icons.library_books),
            title: Text('Terms and Conditions'),
            onTap: () {
              // TODO: Navigate to Terms and Conditions page
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sign Out'),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}

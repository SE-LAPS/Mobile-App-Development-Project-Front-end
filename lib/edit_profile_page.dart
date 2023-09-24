import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String _userName = '';
  String _userEmail = '';
  String _userPhone = '';
  String _userAddress = '';
  // Add more fields as required for editing profile information

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Name'),
              onChanged: (value) {
                setState(() {
                  _userName = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(labelText: 'Email'),
              onChanged: (value) {
                setState(() {
                  _userEmail = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(labelText: 'Phone'),
              onChanged: (value) {
                setState(() {
                  _userPhone = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            TextField(
              decoration: InputDecoration(labelText: 'Address'),
              onChanged: (value) {
                setState(() {
                  _userAddress = value;
                });
              },
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Implement the functionality to update the profile here
                // e.g., call an API to save the updated profile
                // or update the local storage with the new information
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

// You can use this page in your main.dart or wherever it is needed.

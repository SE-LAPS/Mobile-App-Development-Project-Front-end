import 'package:flutter/material.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  String _userName = '';
  String _userEmail = '';
  String _userPhone = '';
  String _userAddress = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Name'),
              onChanged: (value) {
                setState(() {
                  _userName = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: const InputDecoration(labelText: 'Email'),
              onChanged: (value) {
                setState(() {
                  _userEmail = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: const InputDecoration(labelText: 'Phone'),
              onChanged: (value) {
                setState(() {
                  _userPhone = value;
                });
              },
            ),
            const SizedBox(height: 16.0),
            TextField(
              decoration: const InputDecoration(labelText: 'Address'),
              onChanged: (value) {
                setState(() {
                  _userAddress = value;
                });
              },
            ),
            const SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                // Implement the functionality to update the profile here
                // e.g., call an API to save the updated profile
                // or update the local storage with the new information
                
                // Example: Print the updated data
                print('Name: $_userName');
                print('Email: $_userEmail');
                print('Phone: $_userPhone');
                print('Address: $_userAddress');
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class ProfileSettingsPage extends StatefulWidget {
  const ProfileSettingsPage({super.key});
  @override
  State<ProfileSettingsPage> createState() => _ProfileSettingsPageState();
}

class _ProfileSettingsPageState extends State<ProfileSettingsPage> {
  bool _isPasswordHidden = true;

  void _togglePasswordView() {
    setState(() {
      _isPasswordHidden = !_isPasswordHidden;
    });
  }

  final String name = "John Doe";
  final String email = "john.doe@example.com";
  final String password = "123";

  void _showChangePasswordDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final newPasswordController = TextEditingController();
        final confirmPasswordController = TextEditingController();
        return AlertDialog(
          title: const Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: newPasswordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'New Password'),
              ),
              TextField(
                controller: confirmPasswordController,
                obscureText: true,
                decoration:
                    const InputDecoration(labelText: 'Confirm Password'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                if (newPasswordController.text ==
                    confirmPasswordController.text) {
                  // Handle password change logic
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Password changed successfully!'),
                  ));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Passwords do not match!'),
                  ));
                }
              },
              child: const Text('Change'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Settings'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Stack(
              children: <Widget>[
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                      "https://cdn.pixabay.com/photo/2019/08/11/18/59/icon-4399701_1280.png"), // Placeholder image
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    // color: Colors.blue,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadiusDirectional.circular(20.0)),
                    alignment: Alignment.center,
                    child: IconButton(
                      iconSize: 20.0,
                      icon: const Icon(Icons.add_a_photo_outlined,
                          color: Colors.white),
                      onPressed: () {
                        // Handle add image action
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ListTile(
              title: const Text(
                'Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(name),
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Email',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(email),
            ),
            const Divider(),
            ListTile(
              title: const Text(
                'Password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Row(
                children: [
                  Text(_isPasswordHidden ? "••••••••" : password),
                  IconButton(
                    icon: Icon(_isPasswordHidden
                        ? Icons.visibility
                        : Icons.visibility_off),
                    onPressed: _togglePasswordView,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: _showChangePasswordDialog,
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text('Change Password'),
            ),
          ],
        ),
      ),
    );
  }
}

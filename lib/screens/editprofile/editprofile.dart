import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _firstNameController =
      TextEditingController(text: 'Robin');
  final TextEditingController _lastNameController =
      TextEditingController(text: 'Kelvin');
  final TextEditingController _emailController =
      TextEditingController(text: 'robinkelvin9485@gmail.com');
  final TextEditingController _bioController = TextEditingController(
    text:
        'Discover world flavors made easy, with recipes that are simple, reliable, and full of taste.',
  );

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Picture
            Stack(
              alignment: Alignment.bottomRight,
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                    'https://media.istockphoto.com/id/803594496/photo/portrait-of-smiling-chef-wearing-chefs-hat-in-commercial-kitchen.jpg?s=170667a&w=0&k=20&c=aQqxWDtGzZvBkk12Y6Jx-Fea60Hmo4p18wkbDPSV2Bo=',
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: AppTheme.primaryGreen,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),

            // First Name
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('First Name', style: TextStyle(fontSize: 14)),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
            ),
            const SizedBox(height: 20),

            // Last Name
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Last Name', style: TextStyle(fontSize: 14)),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
            ),
            const SizedBox(height: 20),

            // Email
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Email', style: TextStyle(fontSize: 14)),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
            ),
            const SizedBox(height: 20),

            // Bio
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Bio', style: TextStyle(fontSize: 14)),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _bioController,
              maxLines: 4,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              ),
            ),
            const SizedBox(height: 40),

            // Update Profile Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle profile update logic (e.g., API call)
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Profile Updated!')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Update Profile',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
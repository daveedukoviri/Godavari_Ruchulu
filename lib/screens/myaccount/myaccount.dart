import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import 'package:f2/screens/editprofile/editprofile.dart'; // We'll create this next
import 'package:f2/screens/passwordmanager/passwordmanager.dart';

class MyAccountScreen extends StatelessWidget {
  const MyAccountScreen({super.key});

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primaryGreen.withValues(alpha: 0.15),
              ),
              child: Icon(icon, color: AppTheme.primaryGreen, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
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
          'My Account',
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          _buildMenuItem(
            icon: Icons.person_outline,
            title: 'Edit Profile',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EditProfileScreen()),
              );
            },
          ),
          _buildMenuItem(
            icon: Icons.lock_outline,
            title: 'Password Manager',
            onTap: () {
              // Navigate to password manager screen here
              Navigator.push(context, 
              MaterialPageRoute(builder: (_) => const PasswordManagerScreen())
              );

            },
          ),
          // Add more menu items here in the future (e.g., Payment Methods, etc.)
          const Spacer(),
        ],
      ),
    );
  }
}
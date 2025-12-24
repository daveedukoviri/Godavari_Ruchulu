import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../payment/payment.dart';
import '../subscription/subscription.dart';
import '../reviewsubscription/reviewsubscription.dart';
// import '../subscription/subscription.dart';
import '../helpcenter/helpcenter.dart';
import '../myaccount/myaccount.dart';


// import 'package:f2/screens/intro.dart';
// import 'package:f2/screens/home/home.dart';
// import 'package:f2/screens/profile/profilescreen.dart';
// import 'package:f2/screens/notification/notification.dart';
// import 'package:f2/screens/chat/chat.dart';
// import 'package:f2/screens/payment/payment.dart';
// import 'package:f2/screens/myaccount/myaccount.dart';
// import 'package:f2/screens/passwordmanager/passwordmanager.dart';
// import 'package:f2/screens/subscription/subscription.dart';
// import 'package:f2/screens/reviewsubscription/reviewsubscription.dart';
// import 'package:f2/screens/helpcenter/helpcenter.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Widget _buildMenuItem(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppTheme.primaryGreen.withValues(alpha: 0.1),
        ),
        child: Icon(icon, color: AppTheme.primaryGreen, size: 24),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap ?? () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        // leading: IconButton(
        //   onPressed: () => Navigator.pop(context),
        //   icon: Container(
        //     padding: const EdgeInsets.all(6),
        //     decoration: BoxDecoration(
        //       shape: BoxShape.circle,
        //       color: Colors.white,
        //       border: Border.all(color: const Color(0xFFF0F0F0), width: 1.2),
        //     ),
        //     child: const Icon(Icons.arrow_back, color: Colors.black, size: 18),
        //   ),
        // ),

        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,

         actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.grey),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: const NetworkImage(
                      'https://media.istockphoto.com/id/803594496/photo/portrait-of-smiling-chef-wearing-chefs-hat-in-commercial-kitchen.jpg?s=170667a&w=0&k=20&c=aQqxWDtGzZvBkk12Y6Jx-Fea60Hmo4p18wkbDPSV2Bo=',
                    ),
                    backgroundColor: Colors.grey[300],
                    onBackgroundImageError: (_, __) {},
                  ),
                  const SizedBox(width: 16),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Robin Kelvin',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 2),
                      Text(
                        'robinkelvin9485@gmail.com',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // const Divider(height: 1),

            // Menu Items
            _buildMenuItem(Icons.person_outline, 'My Account',
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const MyAccountScreen()),
                )),
            _buildMenuItem(Icons.bookmark_outline, 'Saved Recipes',
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const SubscriptionScreen()),
                )
            ),
            _buildMenuItem(Icons.star_outline, 'My Plan',
            
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ReviewSubscriptionScreen()),
                )
            ),
            _buildMenuItem(
              Icons.payment,
              'Payment Methods',
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PaymentMethodScreen()),
              ),
            ),
            _buildMenuItem(
              Icons.notifications_outlined,
              'Notification Settings',
            ),
            _buildMenuItem(Icons.language, 'Language'),
            _buildMenuItem(Icons.help_outline, 'Help Center',
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const HelpCenterScreen()),
                )
            ),
            _buildMenuItem(Icons.privacy_tip_outlined, 'Privacy Policy'),
            _buildMenuItem(Icons.group_add_outlined, 'Invite Friends'),

            const SizedBox(height: 40),

            // Sign Out Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink[50],
                    foregroundColor: Colors.pink,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.power_settings_new),
                      SizedBox(width: 8),
                      Text(
                        'Sign Out',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}

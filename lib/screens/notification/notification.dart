import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  Widget _buildNotificationItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
    bool hasDivider = true,
  }) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                ),
                child: Icon(icon, color: AppTheme.primaryGreen, size: 24),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        color: AppTheme.gray,
                        fontSize: 13,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Text(
                time,
                style: TextStyle(
                  color: AppTheme.gray,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        if (hasDivider)
          const Divider(height: 1, indent: 72, color: Color(0xFFF0F0F0)),
      ],
    );
  }

  Widget _buildSectionHeader(String title, String actionText, VoidCallback onAction) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextButton(
            onPressed: onAction,
            child: Text(
              actionText,
              style: TextStyle(color: AppTheme.primaryGreen),
            ),
          ),
        ],
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
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search notifications...',
                hintStyle: TextStyle(color: AppTheme.gray),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                suffixIcon: const Icon(Icons.tune, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[100],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),

          Expanded(
            child: ListView(
              children: [
                // Today Section
                _buildSectionHeader('Today', 'Clear All', () {}),

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      _buildNotificationItem(
                        icon: Icons.star_outline,
                        title: 'Upgrade Subscription!',
                        subtitle: 'Your subscription plan...',
                        time: '06:00 PM',
                      ),
                      _buildNotificationItem(
                        icon: Icons.credit_card,
                        title: 'New Card Added!',
                        subtitle: 'Your new card has been...',
                        time: '05:00 PM',
                      ),
                      _buildNotificationItem(
                        icon: Icons.restaurant_menu,
                        title: 'Ran Added New Recipe!',
                        subtitle: 'Ran added a delicious new...',
                        time: '04:30 PM',
                      ),
                      _buildNotificationItem(
                        icon: Icons.credit_card,
                        title: 'New Card Added!',
                        subtitle: 'Your new card has been...',
                        time: '03:45 PM',
                        hasDivider: false,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Yesterday Section
                _buildSectionHeader('Yesterday', 'See All', () {}),

                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      _buildNotificationItem(
                        icon: Icons.restaurant_menu,
                        title: 'You Added New Recipe',
                        subtitle: 'You added a delicious new...',
                        time: 'Thursday',
                      ),
                      _buildNotificationItem(
                        icon: Icons.check_circle_outline,
                        title: 'Account Setup Successful!',
                        subtitle: 'Welcome! Start explorin...',
                        time: 'Thursday',
                        hasDivider: false,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
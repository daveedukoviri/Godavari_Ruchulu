import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

// Import your screens
import '../home/home.dart';
import '../notification/notification.dart';
import '../chat/chat.dart';
// import '../trackorder/trackorder.dart';
// import '../receiptdetails/receiptdetails.dart';
import '../profile/profilescreen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const NotificationsScreen(), // Using as Search tab
    const ChatScreen(), // Using as Favorites tab
    const ProfileScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _buildSmoothIcon(int index, IconData outlineIcon, IconData filledIcon) {
    return GestureDetector(
      onTap: () => _onItemTapped(index),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: _selectedIndex == index
              ? LinearGradient(
                  colors: [
                    AppTheme.primaryGreen.withValues(alpha:0.2),
                    Colors.transparent,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                )
              : null,
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return ScaleTransition(scale: animation, child: child);
          },
          child: Icon(
            _selectedIndex == index ? filledIcon : outlineIcon,
            key: ValueKey(_selectedIndex == index),
            color: _selectedIndex == index ? Colors.white : Colors.white70,
            size: 24,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        backgroundColor: AppTheme.primaryGreen,
        elevation: 4,
        shape: const CircleBorder(),
        onPressed: () {
          // Add new recipe action
        },
        child: const Icon(Icons.add, size: 32, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha:0.1),
              blurRadius: 10,
              spreadRadius: 2,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomAppBar(
          height: 70,
          color: const Color(0xFF042628),
          shape: const CircularNotchedRectangle(),
          notchMargin: 8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSmoothIcon(0, Icons.home_outlined, Icons.home),
              _buildSmoothIcon(1, Icons.notifications_outlined, Icons.notifications),
              const SizedBox(width: 40),
              _buildSmoothIcon(2, Icons.chat_bubble_outline, Icons.chat),
              _buildSmoothIcon(3, Icons.person_outlined, Icons.person),
            ],
          ),
        ),
      ),
    );
  }
}
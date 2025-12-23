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
import 'package:f2/screens/onboard/onboard.dart';
import 'package:f2/theme/app_theme.dart'; // Make sure this path is correct
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Recipe App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const AppEntryPoint(),
    );
  }
}

// Wrapper to handle Splash → Onboarding → Home flow
class AppEntryPoint extends StatefulWidget {
  const AppEntryPoint({super.key});

  @override
  State<AppEntryPoint> createState() => _AppEntryPointState();
}

class _AppEntryPointState extends State<AppEntryPoint> {
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    // Automatically hide splash after 3 seconds (adjust as needed)
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        setState(() {
          _showSplash = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _showSplash ? const SplashScreen() : const OnboardingScreen();
  }
}

// Simple but elegant Splash Screen
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Your app logo or icon (replace with your asset)
            Image.asset(
              'assets/images/logo.png', // Add your logo here
              width: 220,
            ),
            Text(
              'Your Personal Recipe Planner',
              style: TextStyle(fontSize: 16, color: AppTheme.gray),
            ),
            const SizedBox(height: 60),
            CircularProgressIndicator(
              color: AppTheme.primaryGreen,
              strokeWidth: 3,
            ),
          ],
        ),
      ),
    );
  }
}

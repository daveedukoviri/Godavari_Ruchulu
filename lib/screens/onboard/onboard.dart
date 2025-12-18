import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../main/main_navigator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<Color?> _colorAnimation;

  final List<Map<String, dynamic>> onboardingData = [
    {
      'image': 'assets/images/b1.jpg', // Make sure this path is correct in pubspec.yaml
      'title': 'Discover Delicious Recipes',
      'description':
          'Explore thousands of mouth-watering recipes from top chefs around the world.',
      'icon': Icons.restaurant_menu_rounded,
    },
    {
      'image': 'assets/images/b2.jpg',
      'title': 'Cook Like a Pro',
      'description':
          'Follow step-by-step instructions with HD videos to master any dish.',
      'icon': Icons.ondemand_video_rounded,
    },
    {
      'image': 'assets/images/b3.jpg',
      'title': 'Save & Share Favorites',
      'description':
          'Save favorite recipes, create meal plans, and share with friends.',
      'icon': Icons.favorite_border_rounded,
    },
  ];

  @override
  void initState() {
    super.initState();
    
    // Initialize animations AFTER the widget is created
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
      ),
    );

    _colorAnimation = ColorTween(
      begin: AppTheme.primaryGreen.withValues(alpha:0.3),
      end: AppTheme.primaryGreen,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _animationController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Ensure animations are initialized if they weren't already
    if (!_animationController.isAnimating) {
      _animationController.forward();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
    _animationController.reset();
    _animationController.forward();
  }

  Widget _buildPageIndicator(BuildContext context, int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: _currentPage == index ? 28 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? AppTheme.primaryGreen
            : AppTheme.borderColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: _currentPage == index
            ? [
                BoxShadow(
                  color: AppTheme.primaryGreen.withValues(alpha:0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ]
            : null,
      ),
    );
  }

void _navigateToHome(BuildContext context) {
  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      pageBuilder: (_, __, ___) => const MainNavigationScreen(), // ← CHANGE HERE
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 600),
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.lightTheme.copyWith(
        colorScheme: AppTheme.lightTheme.colorScheme.copyWith(
          primary: AppTheme.primaryGreen,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            // Background Pattern
            Positioned.fill(
              child: CustomPaint(painter: _BackgroundPatternPainter()),
            ),

            // PageView
            PageView.builder(
              controller: _pageController,
              itemCount: onboardingData.length,
              onPageChanged: _onPageChanged,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return OnboardingPage(
                  data: onboardingData[index],
                  isActive: index == _currentPage,
                  fadeAnimation: _fadeAnimation,
                  slideAnimation: _slideAnimation,
                  colorAnimation: _colorAnimation,
                );
              },
            ),

            // Skip Button (Top Right)
            Positioned(
              top: MediaQuery.of(context).padding.top + 16,
              right: 20,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 300),
                opacity: _currentPage != onboardingData.length - 1 ? 1.0 : 0.0,
                child: TextButton(
                  onPressed: () => _navigateToHome(context),
                  style: TextButton.styleFrom(
                    foregroundColor: AppTheme.gray,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: AppTheme.gray,
                    ),
                  ),
                ),
              ),
            ),

            // Bottom Navigation
            Positioned(
              bottom: 10,
              left: 0,
              right: 0,
              child: SafeArea(
                child: Column(
                  children: [
                    // Page Indicators
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(
                            0,
                            (1 - _animationController.value) * 20,
                          ),
                          child: Opacity(
                            opacity: _animationController.value,
                            child: child,
                          ),
                        );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          onboardingData.length,
                          (index) => _buildPageIndicator(context, index),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    // Next / Get Started Button
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(scale: animation, child: child);
                      },
                      child: _currentPage == onboardingData.length - 1
                          ? _buildGetStartedButton(context)
                          : _buildNextButton(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextButton(BuildContext context) {
    return SizedBox(
      width: 160,
      child: ElevatedButton(
        onPressed: () {
          _pageController.nextPage(
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryGreen,
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 4,
          shadowColor: AppTheme.primaryGreen.withValues(alpha:0.3),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Next',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward_rounded,
              size: 20,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGetStartedButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: () => _navigateToHome(context),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryGreen,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            elevation: 6,
            shadowColor: AppTheme.primaryGreen.withValues(alpha:0.4),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Get Started',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_rounded,
                size: 24,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool isActive;
  final Animation<double> fadeAnimation;
  final Animation<double> slideAnimation;
  final Animation<Color?> colorAnimation;

  const OnboardingPage({
    super.key,
    required this.data,
    required this.isActive,
    required this.fadeAnimation,
    required this.slideAnimation,
    required this.colorAnimation,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: fadeAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: isActive ? fadeAnimation.value : 1.0,
          child: Transform.translate(
            offset: Offset(0, isActive ? slideAnimation.value : 0),
            child: child,
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            // Top Spacer
            const Spacer(flex: 1),

            // Animated Icon
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen.withValues(alpha:0.1),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppTheme.primaryGreen.withValues(alpha:0.2),
                  width: 2,
                ),
              ),
              child: Icon(
                data['icon'],
                size: 40,
                color: AppTheme.primaryGreen,
              ),
            ),

            const SizedBox(height: 40),

            // Image Container
            Expanded(
              flex: 4,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryDark.withValues(alpha:0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    data['image'],
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppTheme.fieldBg,
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_not_supported_rounded,
                                size: 40,
                                color: AppTheme.gray,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'Image not available',
                                style: TextStyle(
                                  color: AppTheme.gray,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                data['title'],
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryDark,
                  height: 1.2,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                data['description'],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppTheme.gray,
                  height: 1.6,
                ),
              ),
            ),

            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}

class _BackgroundPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.fieldBg
      ..style = PaintingStyle.fill;

    // Draw subtle background pattern
    for (double i = 0; i < size.width; i += 40) {
      for (double j = 0; j < size.height; j += 40) {
        canvas.drawCircle(Offset(i, j), 1, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
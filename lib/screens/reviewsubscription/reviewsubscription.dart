import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class ReviewSubscriptionScreen extends StatelessWidget {
  const ReviewSubscriptionScreen({super.key});

  // Simulate showing the success dialog
  void _showSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      
      builder: (BuildContext dialogContext) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const AnimatedTick(),
                const SizedBox(height: 24),
                const Text(
                  'Your Subscription is Active.\nEnjoy Full Access!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 32),
                _buildDetailRow('Payment Method', 'Master Card'),
                const SizedBox(height: 12),
                _buildDetailRow('Card Number', '6912 ****  7251'),
                const SizedBox(height: 12),
                _buildDetailRow('Price', '\$6.00'),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      // Navigator.of(context).pop(); // Uncomment if you want to go back after closing
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryGreen,
                      padding: const EdgeInsets.symmetric(vertical: 18),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: AppTheme.gray, fontSize: 15),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: _buildDetailRow(label, value),
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
          'Review',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Crown icon
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: Color(0xFFFFF4E5),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.auto_awesome,
                color: Color(0xFFF9A825),
                size: 40,
              ),
            ),
            const SizedBox(height: 32),

            // Plan details
            _buildInfoCard('Plan', 'Foomly Annual Plan'),
            _buildInfoCard('Validity', '(26 Nov. 2025-26 Nov. 2026)'),
            _buildInfoCard('Name', 'Robin Kelvin'),
            _buildInfoCard('Email', 'robinkelvin9485@gmail.com'),
            _buildInfoCard('Payment Method', 'Master Card'),
            _buildInfoCard('Card Number', '6912 **** **** 7251'),
            _buildInfoCard('Price', '\$6.00'),
            _buildInfoCard('Fee', '\$0.00'),
            _buildInfoCard('Total Price', '\$6.00'),

            const SizedBox(height: 40),

            // Subscribe Now Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => _showSuccessDialog(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Subscribe Now',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40), // Extra safe bottom padding
          ],
        ),
      ),
    );
  }
}




class AnimatedTick extends StatefulWidget {
  const AnimatedTick({super.key});

  @override
  State<AnimatedTick> createState() => _AnimatedTickState();
}

class _AnimatedTickState extends State<AnimatedTick>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _circleScale;
  late Animation<double> _tickProgress;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _circleScale = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.45, curve: Curves.elasticOut),
      ),
    );

    _tickProgress = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.45, 1.0, curve: Curves.easeOut),
      ),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 90,
      height: 90,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Transform.scale(
            scale: _circleScale.value,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primaryGreen.withValues(alpha: 0.15),
              ),
              child: CustomPaint(
                painter: _TickPainter(progress: _tickProgress.value),
              ),
            ),
          );
        },
      ),
    );
  }
}


class _TickPainter extends CustomPainter {
  final double progress;

  _TickPainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppTheme.primaryGreen
      ..strokeWidth = 6
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();

    final start = Offset(size.width * 0.28, size.height * 0.52);
    final mid = Offset(size.width * 0.43, size.height * 0.66);
    final end = Offset(size.width * 0.72, size.height * 0.34);

    path.moveTo(start.dx, start.dy);
    path.lineTo(mid.dx, mid.dy);
    path.lineTo(end.dx, end.dy);

    final metrics = path.computeMetrics().first;
    final extractPath =
        metrics.extractPath(0, metrics.length * progress);

    canvas.drawPath(extractPath, paint);
  }

  @override
  bool shouldRepaint(covariant _TickPainter oldDelegate) =>
      oldDelegate.progress != progress;
}

import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class SubscriptionScreen extends StatefulWidget {
  const SubscriptionScreen({super.key});

  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  int _selectedPlan = 1; // 0: Monthly, 1: Annual

  Widget _buildPlanOption({
    required String title,
    required String price,
    required int value,
  }) {
    bool isSelected = _selectedPlan == value;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedPlan = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(16),
          border: isSelected
              ? Border.all(color: AppTheme.primaryGreen, width: 2)
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Row(
              children: [
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isSelected ? AppTheme.primaryGreen : Colors.black,
                  ),
                ),
                const SizedBox(width: 12),
                // Custom filled circle for selected state
                Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppTheme.primaryGreen, width: 2),
                    color: isSelected ? AppTheme.primaryGreen : Colors.transparent,
                  ),
                  child: isSelected
                      ? const Icon(Icons.circle, color: Colors.white, size: 14)
                      : null,
                ),
              ],
            ),
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
          'Subscription',
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Unlock All Features',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Text(
              'Unlock premium recipes, HD videos, and smart cooking tools to make every meal perfect.',
              style: TextStyle(color: AppTheme.gray, fontSize: 14),
            ),
            const SizedBox(height: 32),

            // Annual Plan Card (Highlighted)
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppTheme.primaryGreen,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$6.00',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        '/annual',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Foomly Annual Plan',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Enjoy full access to Foomly Planner\'s features for a full year.',
                    style: TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: const [
                        _FeatureItem(text: 'Unlimited Recipes & Saves'),
                        _FeatureItem(text: 'Ad Free Experience'),
                        _FeatureItem(text: 'Advanced Search & Filtering'),
                        _FeatureItem(text: 'Multi-Device Sync & Cloud Storage'),
                        _FeatureItem(text: 'Full HD Cooking Videos'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Plan Selection
            _buildPlanOption(
              title: 'Monthly',
              price: '\$4.00',
              value: 0,
            ),
            const SizedBox(height: 12),
            _buildPlanOption(
              title: 'Annual',
              price: '\$6.00',
              value: 1,
            ),

            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Starting 7 Days Free Trial!')),
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
                  'Start 7 Days Free Trial',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
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

class _FeatureItem extends StatelessWidget {
  final String text;
  const _FeatureItem({required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(Icons.check, color: AppTheme.primaryGreen, size: 20),
          const SizedBox(width: 12),
          Text(text, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
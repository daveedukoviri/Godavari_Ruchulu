import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class PaymentMethodScreen extends StatefulWidget {
  const PaymentMethodScreen({super.key});

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  int _selectedWallet = 0; // 0: PayPal, 1: Google Pay, 2: Apple Pay

  Widget _walletTile({
    required Widget logo,
    required String title,
    required int value,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        leading: logo,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Radio<int>(
          value: value,
          activeColor: AppTheme.primaryGreen,
        ),
        onTap: () {
          setState(() {
            _selectedWallet = value;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      // ================= APP BAR =================
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey.shade400),
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 20,
            ),
          ),
        ),
        title: const Text(
          'Payment Method',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),

      // ================= BODY =================
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Payment Options',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            RadioGroup<int>(
              groupValue: _selectedWallet,
              onChanged: (int? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedWallet = newValue;
                  });
                }
              },
              child: Column(
                children: [
                  _walletTile(
                    logo: Image.asset('assets/images/pp.png', width: 60),
                    title: 'PayPal',
                    value: 0,
                  ),
                  _walletTile(
                    logo: Image.asset('assets/images/gp.png', width: 60),
                    title: 'Google Pay',
                    value: 1,
                  ),
                  _walletTile(
                    logo: Image.asset('assets/images/ap.png', width: 60),
                    title: 'Apple Pay',
                    value: 2,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            const Text(
              'Cred & Debit Card',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),

            GestureDetector(
              onTap: () {
                // Navigate to add card screen
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
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
                      child: const Icon(
                        Icons.credit_card,
                        color: AppTheme.primaryGreen,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Text(
                        'Add Card',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const Icon(Icons.chevron_right, color: Colors.grey),
                  ],
                ),
              ),
            ),

            const Spacer(),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  _priceRow('Price', '\$6.00'),
                  const SizedBox(height: 12),
                  _priceRow('Fee', '\$0.00'),
                  const Divider(height: 32),
                  _priceRow('Total', '\$6.00', isTotal: true),
                ],
              ),
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 13),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Continue',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _priceRow(String label, String value, {bool isTotal = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: isTotal ? 18 : 16,
            fontWeight: FontWeight.bold,
            color: isTotal ? AppTheme.primaryGreen : Colors.black,
          ),
        ),
      ],
    );
  }
}
import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../../utils/loader.dart';
import '../payment/payment.dart';

class Receiptdetails extends StatefulWidget {
  final Map<String, dynamic> recipe;
  
  const Receiptdetails({super.key, required this.recipe});

  @override
  State<Receiptdetails> createState() => _ReceiptdetailsState();
}

class _ReceiptdetailsState extends State<Receiptdetails> {
  String _selectedMeal = 'Double Meal (200g)';
  final List<String> _selectedExtras = ['Mozzarella', 'Ketchup'];
  int _quantity = 2;

  Future<void> _onPayment() async {
    // Show full-screen loader with custom animation
    LoaderOverlay.show(
      context: context,
      lottieAsset: 'assets/icons/load.json',
      message: 'Plate ready… Taste loading 😋...',
    );

    // Simulate processing (replace with real logic later)
    await Future.delayed(const Duration(seconds: 3));

    // Hide loader
    LoaderOverlay.hide();

    if (!mounted) return;

    // Navigate to next page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const PaymentMethodScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: AppTheme.lightTheme,
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            children: [
              // Hero Image
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.42,
                width: double.infinity,
                child:Image.network(
                  widget.recipe['imageUrl'], // Use the recipe's image
                  fit: BoxFit.cover,
                ),
              ),

              // Close Button
              Positioned(
                top: 16,
                left: 16,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 8,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.close,
                      color: AppTheme.primaryDark,
                      size: 24,
                    ),
                  ),
                ),
              ),

              // Bottom Sheet
              DraggableScrollableSheet(
                initialChildSize: 0.62,
                minChildSize: 0.62,
                maxChildSize: 0.95,
                builder: (context, scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(32),
                      ),
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Drag Handle
                          Center(
                            child: Container(
                              width: 48,
                              height: 5,
                              decoration: BoxDecoration(
                                color: AppTheme.dividerColor,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),

                          // Title
                          Text(
                              widget.recipe['title'] as String,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),

                          // Description
                          Text(
                            'Crumblets of creamy French blue cheese top our famous burger patty with our signature mayonnaise sauce.',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.gray,
                              height: 1.5,
                            ),
                          ),
                          const SizedBox(height: 32),

                          // Required Section Header - FIXED OVERFLOW
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Your Choice Of Burger',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    height: 1.4,
                                  ),
                                ),
                              ),

                              const SizedBox(width: 12),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: AppTheme.primaryGreen, // ✅ FILL GREEN
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'Required',
                                  style: TextStyle(
                                    color: Colors.white, // ✅ WHITE TEXT
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '(Choose 1)',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.gray,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Radio Options
                          _buildRadioOption(
                            'Single Meal (120g)',
                            '+EGP 249.00',
                            'Single Meal (120g)',
                          ),
                          _buildRadioOption(
                            'Double Meal (200g)',
                            '+EGP 289.00',
                            'Double Meal (200g)',
                            isSelected: true,
                          ),
                          _buildRadioOption(
                            'Triple (250g)',
                            '+EGP 310.00',
                            'Triple (250g)',
                          ),

                          const SizedBox(height: 32),

                          // Extra Section Header - FIXED OVERFLOW
                          Row(
                            children: [
                              const Expanded(
                                child: Text(
                                  'Extra',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(color: AppTheme.gray),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Text(
                                  'Optional',
                                  style: TextStyle(
                                    color: AppTheme.gray,
                                    fontSize: 13,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Choose up to 18 item',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppTheme.gray,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Checkbox Options
                          _buildCheckboxOption('Cheddar', '+EGP 15.00'),
                          _buildCheckboxOption(
                            'Mozzarella',
                            '+EGP 20.00',
                            isSelected: true,
                            hasPopular: true,
                          ),
                          _buildCheckboxOption('BBQ sauce', '+EGP 10.00'),
                          _buildCheckboxOption(
                            'Ketchup',
                            '+EGP 20.00',
                            isSelected: true,
                          ),

                          const SizedBox(height: 40),

                          // Bottom Row: Quantity + Add to Cart
                          Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: AppTheme.borderColor,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Minus button
                                    Material(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(30),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(30),
                                        onTap: () {
                                          if (_quantity > 1) {
                                            setState(() => _quantity--);
                                          }
                                        },
                                        child: const Padding(
                                          padding: EdgeInsets.all(
                                            15.0,
                                          ), // Adjust this value
                                          child: Icon(Icons.remove, size: 14),
                                        ),
                                      ),
                                    ),

                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 2,
                                      ),
                                      child: Text(
                                        '$_quantity',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),

                                    // Plus button
                                    Material(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.circular(30),
                                      child: InkWell(
                                        borderRadius: BorderRadius.circular(30),
                                        onTap: () =>
                                            setState(() => _quantity++),
                                        child: const Padding(
                                          padding: EdgeInsets.all(
                                            15.0,
                                          ), // Adjust this value
                                          child: Icon(Icons.add, size: 14),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {},
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: AppTheme.primaryGreen
                                        .withValues(alpha: 0.2),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    side: BorderSide.none,
                                    elevation: 0,
                                  ),

                                  child: const Text(
                                    'Add to Cart',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: AppTheme.primaryGreen,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: _onPayment,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.primaryGreen,
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 14,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: const Text(
                                    'Buy Now  ',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom Radio - Exact Match
  Widget _buildRadioOption(
    String title,
    String price,
    String value, {
    bool isSelected = false,
  }) {
    bool selected = _selectedMeal == value;
    return GestureDetector(
      onTap: () => setState(() => _selectedMeal = value),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(price, style: TextStyle(color: AppTheme.gray, fontSize: 14)),
            const SizedBox(width: 16),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected
                      ? AppTheme.primaryGreen
                      : Colors.grey.shade400,
                  width: 2,
                ),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppTheme.primaryGreen,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  // Custom Checkbox - Exact Match
  Widget _buildCheckboxOption(
    String title,
    String price, {
    bool isSelected = false,
    bool hasPopular = false,
  }) {
    bool checked = _selectedExtras.contains(title);
    return GestureDetector(
      onTap: () => setState(() {
        checked ? _selectedExtras.remove(title) : _selectedExtras.add(title);
      }),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Text(title, style: const TextStyle(fontSize: 14)),
                  if (hasPopular) ...[
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors
                            .orange
                            .shade100, // 🌤 light orange background
                        borderRadius: const BorderRadius.all(
                          Radius.circular(20),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.local_fire_department,
                            color: Colors.orange.shade700,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            'Popular',
                            style: TextStyle(
                              color: Colors.orange.shade700,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Text(price, style: TextStyle(color: AppTheme.gray, fontSize: 14)),
            const SizedBox(width: 16),

            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                border: Border.all(
                  color: checked ? AppTheme.primaryGreen : Colors.grey.shade400,
                  width: 2,
                ),
                color: checked ? AppTheme.primaryGreen : Colors.transparent,
              ),
              child: checked
                  ? const Icon(Icons.check, color: Colors.white, size: 16)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int? _expandedIndex = 1; // only the offline question is expanded in FAQ tab

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
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
          'Help Center',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search bar
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search chef...',
                hintStyle: TextStyle(color: Colors.grey[600]),
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

          // Tabs with green underline
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TabBar(
              controller: _tabController,
              labelColor: AppTheme.primaryGreen,
              unselectedLabelColor: Colors.grey[600],
              indicatorColor: AppTheme.primaryGreen,
              indicatorWeight: 3,
              indicatorSize: TabBarIndicatorSize.tab, // 👈 SAME SIZE for both
              dividerColor: Colors.transparent,
              tabs: const [
                Tab(text: "FAQ's"),
                Tab(text: "Contact Us"),
              ],
            ),
          ),

          // Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // === FAQ's Tab ===
                ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  children: List.generate(8, (index) {
                    final questions = [
                      'How do I save a recipe?',
                      'Can I use the app offline?',
                      'Can I upload my own recipe?',
                      'How do I search by ingredients?',
                      'Is the app free?',
                      'How do I share recipes?',
                      'Can I favorite recipes?',
                      'Can I rate recipes?',
                    ];

                    final answers = [
                      'Tap the bookmark icon on any recipe to save it to your collection.',
                      'Saved recipes are available offline. You need internet to browse new recipes.',
                      'Yes, you can upload your own recipes from the Add Recipe section.',
                      'Use the search bar and enter ingredients to find matching recipes.',
                      'Yes, the app is free with optional premium features.',
                      'Open a recipe and tap the share icon to send it to friends or social apps.',
                      'Yes, tap the heart icon to add recipes to your favorites.',
                      'Yes, you can rate recipes after viewing or cooking them.',
                    ];

                    final bool isExpanded = _expandedIndex == index;

                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _expandedIndex = isExpanded ? null : index;
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: EdgeInsets.symmetric(
                          vertical: isExpanded ? 16 : 12,
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                          color: isExpanded
                              ? const Color(0xFFF5FFF9)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    questions[index],
                                    style: const TextStyle(
                                      fontSize: 15.5,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  if (isExpanded && answers[index].isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Text(
                                        answers[index],
                                        style: TextStyle(
                                          color: AppTheme.gray,
                                          fontSize: 14,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                            Icon(
                              isExpanded ? Icons.remove : Icons.add,
                              color: AppTheme.primaryGreen,
                              size: 28,
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ),

                // === Contact Us Tab ===
                ListView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 20,
                  ),
                  children: [
                    ContactItem(
                      icon: Icons.chat_bubble_outline,
                      color: AppTheme.primaryGreen,
                      title: 'Live Chat',
                    ),
                    ContactItem(
                      icon: Icons.language,
                      color: AppTheme.primaryGreen,
                      title: 'Website',
                    ),
                    ContactItem(
                      icon: Icons.close,
                      color: AppTheme.primaryGreen,
                      title: 'X',
                    ),
                    ContactItem(
                      icon: Icons.camera_alt,
                      color: AppTheme.primaryGreen,
                      title: 'Instagram',
                    ),
                    ContactItem(
                      icon: Icons.message,
                      color: AppTheme.primaryGreen,
                      title: 'WhatsApp',
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Reusable Contact Us item – exactly as in your latest image
class ContactItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String title;

  const ContactItem({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ],
      ),
    );
  }
}

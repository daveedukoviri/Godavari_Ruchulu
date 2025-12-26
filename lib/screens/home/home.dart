import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../receiptdetails/receiptdetails.dart';
import '../notification/notification.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import '../../utils/loader.dart'; // Add this import

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';
  final List<String> _categories = [
    'All',
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snacks',
    'Dessert',
  ];

  // Search and filter variables
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Filter variables
  double _minPrice = 0;
  double _maxPrice = 30;
  double _minRating = 0;
  double _maxRating = 5;
  bool _isVegOnly = false;
  bool _isNonVegOnly = false;
  String _selectedArea = 'All';
  final List<String> _areas = [
    'All',
    'Italian',
    'Mexican',
    'Indian',
    'Asian',
    'American',
    'Mediterranean',
  ];
  String _selectedPrepTime = 'All';
  final List<String> _prepTimes = [
    'All',
    'Quick (<15 min)',
    'Medium (15-30 min)',
    'Long (>30 min)',
  ];

  late List<Map<String, dynamic>> _recipes = [];
  bool _isLoading = true;
  bool _showMoreRecipes = false; // New variable to control show more
  final int _initialRecipeCount = 8; // Show 8 recipes initially
  

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    try {
      final jsonString = await rootBundle.loadString(
        'assets/data/recipes.json',
      );
      final jsonList = json.decode(jsonString) as List;
      _recipes = jsonList.cast<Map<String, dynamic>>();

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading recipes: $e');
      _recipes = [];
      _isLoading = false;
      setState(() {});
    }
  }

  List<Map<String, dynamic>> get _filteredRecipes {
    List<Map<String, dynamic>> filteredList = _recipes;

    if (_selectedCategory != 'All') {
      filteredList = filteredList
          .where((recipe) => recipe['category'] == _selectedCategory)
          .toList();
    }

    if (_searchQuery.isNotEmpty) {
      filteredList = filteredList.where((recipe) {
        final title = recipe['title'].toString().toLowerCase();
        final chef = recipe['chef'].toString().toLowerCase();
        final category = recipe['category'].toString().toLowerCase();
        final area = recipe['area'].toString().toLowerCase();
        return title.contains(_searchQuery.toLowerCase()) ||
            chef.contains(_searchQuery.toLowerCase()) ||
            category.contains(_searchQuery.toLowerCase()) ||
            area.contains(_searchQuery.toLowerCase());
      }).toList();
    }

    filteredList = filteredList.where((recipe) {
      final price = recipe['price'] as double;
      return price >= _minPrice && price <= _maxPrice;
    }).toList();

    filteredList = filteredList.where((recipe) {
      final rating = recipe['rating'] as double;
      return rating >= _minRating && rating <= _maxRating;
    }).toList();

    if (_isVegOnly && !_isNonVegOnly) {
      filteredList = filteredList
          .where((recipe) => recipe['isVeg'] == 'true')
          .toList();
    } else if (!_isVegOnly && _isNonVegOnly) {
      filteredList = filteredList
          .where((recipe) => recipe['isVeg'] == 'false')
          .toList();
    }

    if (_selectedArea != 'All') {
      filteredList = filteredList
          .where((recipe) => recipe['area'] == _selectedArea)
          .toList();
    }

    if (_selectedPrepTime != 'All') {
      filteredList = filteredList.where((recipe) {
        final prepTime = recipe['prepTimeMinutes'] as int;
        if (_selectedPrepTime == 'Quick (<15 min)') {
          return prepTime < 15;
        } else if (_selectedPrepTime == 'Medium (15-30 min)') {
          return prepTime >= 15 && prepTime <= 30;
        } else {
          return prepTime > 30;
        }
      }).toList();
    }

    return filteredList;
  }

  // Get recipes to display (limited or all)
  List<Map<String, dynamic>> get _displayRecipes {
    if (_showMoreRecipes || _filteredRecipes.length <= _initialRecipeCount) {
      return _filteredRecipes;
    }
    return _filteredRecipes.sublist(0, _initialRecipeCount);
  }

  void _resetFilters() {
    setState(() {
      _minPrice = 0;
      _maxPrice = 30;
      _minRating = 0;
      _maxRating = 5;
      _isVegOnly = false;
      _isNonVegOnly = false;
      _selectedArea = 'All';
      _selectedPrepTime = 'All';
    });
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Expanded(
                child: StatefulBuilder(
                  builder: (context, setModalState) => ListView(
                    controller: controller,
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 40),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Filter Recipes',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryDark,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.close),
                            onPressed: () => Navigator.pop(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      _buildFilterSection(
                        title: 'Price Range',
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        'MIN',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppTheme.gray,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppTheme.primaryGreen
                                              .withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Text(
                                          '\$${_minPrice.round()}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.primaryGreen,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: 2,
                                    width: 20,
                                    color: AppTheme.primaryGreen.withValues(
                                      alpha: 0.3,
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        'MAX',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: AppTheme.gray,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppTheme.primaryGreen
                                              .withValues(alpha: 0.1),
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        child: Text(
                                          '\$${_maxPrice.round()}',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                            color: AppTheme.primaryGreen,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: RangeSlider(
                                values: RangeValues(_minPrice, _maxPrice),
                                min: 0,
                                max: 30,
                                divisions: 30,
                                activeColor: AppTheme.primaryGreen,
                                inactiveColor: AppTheme.primaryGreen.withValues(
                                  alpha: 0.1,
                                ),
                                overlayColor: WidgetStateProperty.all(
                                  AppTheme.primaryGreen.withValues(alpha: 0.1),
                                ),
                                labels: RangeLabels(
                                  '\$${_minPrice.round()}',
                                  '\$${_maxPrice.round()}',
                                ),
                                onChanged: (v) => setModalState(() {
                                  _minPrice = v.start;
                                  _maxPrice = v.end;
                                }),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '\$0',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.gray,
                                  ),
                                ),
                                Text(
                                  '\$30',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: AppTheme.gray,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      _buildFilterSection(
                        title: 'Minimum Rating',
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        color: AppTheme.primaryGreen,
                                        size: 28,
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        _minRating.toStringAsFixed(1),
                                        style: TextStyle(
                                          fontSize: 28,
                                          fontWeight: FontWeight.w700,
                                          color: AppTheme.primaryGreen,
                                        ),
                                      ),
                                      Text(
                                        ' / 5',
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: AppTheme.gray,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Minimum rating to show',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppTheme.gray,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: Slider(
                                value: _minRating,
                                min: 0,
                                max: 5,
                                divisions: 50,
                                activeColor: AppTheme.primaryGreen,
                                inactiveColor: AppTheme.primaryGreen.withValues(
                                  alpha: 0.1,
                                ),
                                overlayColor: WidgetStateProperty.all(
                                  AppTheme.primaryGreen.withValues(alpha: 0.1),
                                ),
                                label: _minRating.toStringAsFixed(1),
                                onChanged: (value) => setModalState(() {
                                  _minRating = value;
                                }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 4,
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(6, (index) {
                                  return Text(
                                    '$index',
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: index <= _minRating.round()
                                          ? AppTheme.primaryGreen
                                          : AppTheme.gray,
                                      fontWeight: index <= _minRating.round()
                                          ? FontWeight.w600
                                          : FontWeight.normal,
                                    ),
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      _buildFilterSection(
                        title: 'Food Type',
                        child: Row(
                          children: [
                            Flexible(
                              child: FilterChip(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                label: Text(
                                  'Vegetarian',
                                  style: TextStyle(
                                    color: _isVegOnly
                                        ? Colors.white
                                        : AppTheme.primaryGreen,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                selected: _isVegOnly,
                                backgroundColor: AppTheme.primaryGreen
                                    .withValues(alpha: 0.3),
                                selectedColor: AppTheme.primaryGreen,
                                side: BorderSide.none,
                                checkmarkColor: Colors.white,
                                showCheckmark: _isVegOnly,
                                onSelected: (v) => setModalState(() {
                                  _isVegOnly = v;
                                  if (v) _isNonVegOnly = false;
                                }),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Flexible(
                              child: FilterChip(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                label: Text(
                                  'Non-Vegetarian',
                                  style: TextStyle(
                                    color: _isNonVegOnly
                                        ? Colors.white
                                        : AppTheme.primaryGreen,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                selected: _isNonVegOnly,
                                backgroundColor: AppTheme.primaryGreen
                                    .withValues(alpha: 0.3),
                                selectedColor: AppTheme.primaryGreen,
                                side: BorderSide.none,
                                checkmarkColor: Colors.white,
                                showCheckmark: _isNonVegOnly,
                                onSelected: (v) => setModalState(() {
                                  _isNonVegOnly = v;
                                  if (v) _isVegOnly = false;
                                }),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      _buildFilterSection(
                        title: 'Cuisine',
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: _areas.map((area) {
                            final bool isSelected = _selectedArea == area;
                            return FilterChip(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              label: Text(
                                area,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : AppTheme.primaryGreen,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              selected: isSelected,
                              backgroundColor: AppTheme.primaryGreen.withValues(
                                alpha: 0.3,
                              ),
                              selectedColor: AppTheme.primaryGreen,
                              side: BorderSide.none,
                              checkmarkColor: Colors.white,
                              showCheckmark: isSelected,
                              onSelected: (v) => setModalState(
                                () => _selectedArea = v ? area : 'All',
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      const SizedBox(height: 24),

                      _buildFilterSection(
                        title: 'Preparation Time',
                        child: Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children: _prepTimes.map((time) {
                            final bool isSelected = _selectedPrepTime == time;
                            return FilterChip(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              label: Text(
                                time,
                                style: TextStyle(
                                  color: isSelected
                                      ? Colors.white
                                      : AppTheme.primaryGreen,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              selected: isSelected,
                              backgroundColor: AppTheme.primaryGreen.withValues(
                                alpha: 0.3,
                              ),
                              selectedColor: AppTheme.primaryGreen,
                              side: BorderSide.none,
                              checkmarkColor: Colors.white,
                              showCheckmark: isSelected,
                              onSelected: (v) => setModalState(
                                () => _selectedPrepTime = v ? time : 'All',
                              ),
                            );
                          }).toList(),
                        ),
                      ),

                      const SizedBox(height: 40),

                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: _resetFilters,
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                side: BorderSide(color: AppTheme.primaryGreen),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              icon: Icon(
                                Icons.refresh,
                                color: AppTheme.primaryGreen,
                                size: 18,
                              ),
                              label: Text(
                                'Reset',
                                style: TextStyle(
                                  color: AppTheme.primaryGreen,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                                setState(() {});
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryGreen,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 0,
                              ),
                              icon: const Icon(Icons.check, size: 18),
                              label: const Text(
                                'Apply',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSection({required String title, required Widget child}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppTheme.primaryDark,
          ),
        ),
        const SizedBox(height: 12),
        child,
      ],
    );
  }

  Widget _buildChefAvatar(String name, String imageUrl) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 33,
            backgroundColor: const Color.fromARGB(255, 64, 180, 132),
            child: CircleAvatar(
              radius: 32,
              backgroundImage: NetworkImage(imageUrl),
              backgroundColor: Colors.grey[300],
              onBackgroundImageError: (_, __) {},
            ),
          ),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildCategoryTab(String title, bool isActive, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isActive ? AppTheme.primaryGreen : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isActive ? AppTheme.primaryGreen : Colors.grey.shade300,
              width: 1,
            ),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppTheme.primaryGreen.withValues(alpha: 0.2),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
              color: isActive ? Colors.white : Colors.grey.shade700,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRecipeCard(Map<String, dynamic> recipe) {
    final bool isVeg = recipe['isVeg'] == 'true';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => Receiptdetails(recipe: recipe)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section
            SizedBox(
              height: 125,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      recipe['imageUrl'] as String,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(Icons.restaurant, color: Colors.grey),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Colors.black.withValues(alpha: 0.3),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      left: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.star,
                              color: AppTheme.primaryGreen,
                              size: 12,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              recipe['rating'].toString(),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: AppTheme.primaryDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryGreen,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          '\$${recipe['price']}',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Content Section
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe['title'] as String,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    recipe['chef'] as String,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: AppTheme.gray),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.remove_red_eye_outlined,
                            size: 12,
                            color: AppTheme.gray,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            recipe['views'] as String,
                            style: TextStyle(
                              fontSize: 11,
                              color: AppTheme.gray,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          recipe['prepTime'] as String? ?? '30 min',
                          style: TextStyle(
                            fontSize: 10,
                            color: AppTheme.primaryGreen,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Bottom Bar
            Container(
              height: 36,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
                border: Border(
                  top: BorderSide(
                    color: Colors.grey.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.favorite_border,
                          size: 14,
                          color: AppTheme.gray,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '2.5K',
                          style: TextStyle(fontSize: 11, color: AppTheme.gray),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 6,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isVeg
                                    ? const Color(0xFF4CAF50)
                                    : const Color(0xFFF44336),
                                width: 2,
                              ),
                            ),
                            child: Center(
                              child: Container(
                                width: 4,
                                height: 4,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isVeg
                                      ? const Color(0xFF4CAF50)
                                      : const Color(0xFFF44336),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            isVeg ? 'Veg' : 'Non-veg',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppTheme.primaryGreen,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(Icons.share_outlined, size: 14, color: AppTheme.gray),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: _categories.map((category) {
          return _buildCategoryTab(
            category,
            _selectedCategory == category,
            () => setState(() => _selectedCategory = category),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildActiveFilters() {
    List<Widget> chips = [];

    if (_minPrice > 0 || _maxPrice < 30) {
      chips.add(
        _buildFilterChip(
          label: '\$${_minPrice.round()}-\$${_maxPrice.round()}',
          onTap: () {
            setState(() {
              _minPrice = 0;
              _maxPrice = 30;
            });
          },
        ),
      );
    }

    if (_minRating > 0 || _maxRating < 5) {
      chips.add(
        _buildFilterChip(
          label:
              '${_minRating.toStringAsFixed(1)}-${_maxRating.toStringAsFixed(1)} ⭐',
          onTap: () {
            setState(() {
              _minRating = 0;
              _maxRating = 5;
            });
          },
        ),
      );
    }

    if (_isVegOnly) {
      chips.add(
        _buildFilterChip(
          label: 'Vegetarian',
          onTap: () {
            setState(() {
              _isVegOnly = false;
            });
          },
        ),
      );
    }

    if (_isNonVegOnly) {
      chips.add(
        _buildFilterChip(
          label: 'Non-Veg',
          onTap: () {
            setState(() {
              _isNonVegOnly = false;
            });
          },
        ),
      );
    }

    if (_selectedArea != 'All') {
      chips.add(
        _buildFilterChip(
          label: _selectedArea,
          onTap: () {
            setState(() {
              _selectedArea = 'All';
            });
          },
        ),
      );
    }

    if (_selectedPrepTime != 'All') {
      chips.add(
        _buildFilterChip(
          label: _selectedPrepTime,
          onTap: () {
            setState(() {
              _selectedPrepTime = 'All';
            });
          },
        ),
      );
    }

    if (chips.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Wrap(spacing: 8, runSpacing: 8, children: chips),
      ],
    );
  }

  Widget _buildFilterChip({
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppTheme.primaryGreen.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppTheme.primaryGreen.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                color: AppTheme.primaryGreen,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: 6),
            Icon(Icons.close, size: 14, color: AppTheme.primaryGreen),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: CircularProgressIndicator(color: AppTheme.primaryGreen),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 4,
        surfaceTintColor: AppTheme.primaryGreen.withValues(alpha: 0.08),
        toolbarHeight: 80,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hi Kelvin',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFFc7c7c7),
              ),
            ),
            Text(
              'Craving A Dish ?',
              style: TextStyle(fontSize: 18, color: AppTheme.primaryDark),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_outlined,
              color: AppTheme.primaryGreen,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
              );
            },
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        hintText: 'Search recipes, chefs, or cuisine...',
                        hintStyle: TextStyle(color: AppTheme.gray),
                        prefixIcon: const Icon(Icons.search),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (_searchController.text.isNotEmpty)
                              IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                  setState(() {
                                    _searchQuery = '';
                                  });
                                },
                              ),
                            IconButton(
                              icon: const Icon(Icons.tune),
                              onPressed: () => _showFilterBottomSheet(context),
                              color: AppTheme.primaryGreen,
                            ),
                          ],
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: 14,
                          horizontal: 16,
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _searchQuery = value;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 4),
                ],
              ),
              const SizedBox(height: 16),

              _buildActiveFilters(),

              const SizedBox(height: 8),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Top Chef',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'See All',
                      style: TextStyle(color: AppTheme.primaryGreen),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildChefAvatar(
                      'Liam',
                      'https://t4.ftcdn.net/jpg/01/41/56/45/360_F_141564503_tAcki4lMMh38x9z09kgfuk4iTfV3JcX2.jpg',
                    ),
                    _buildChefAvatar(
                      'Henry',
                      'https://thumbs.dreamstime.com/b/portrait-cook-white-background-29870501.jpg',
                    ),
                    _buildChefAvatar(
                      'Noah',
                      'https://thumbs.dreamstime.com/b/female-chef-whisk-circular-logo-design-vector-generative-ai-style-illustration-hat-holding-perfect-394683027.jpg',
                    ),
                    _buildChefAvatar(
                      'Oliver',
                      'https://t4.ftcdn.net/jpg/01/41/56/45/360_F_141564503_tAcki4lMMh38x9z09kgfuk4iTfV3JcX2.jpg',
                    ),
                    _buildChefAvatar(
                      'James',
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdf21yEk40TalbpFvynfXngZinrbDZvMdXPQ&s',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Container(
                padding: const EdgeInsets.only(
                  top: 16,
                  left: 16,
                  right: 0,
                  bottom: 16,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F5E8),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Unlock All Recipes!',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primaryDark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Watch premium recipes.\nno limits.',
                            style: TextStyle(color: AppTheme.gray),
                          ),
                          const SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppTheme.primaryGreen,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: const Text(
                              'Subscribe',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Image.asset(
                      'assets/images/food.png',
                      width: 140,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),

              const Text(
                'Trending Recipes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 8),

              _buildCategoryTabs(),
              const SizedBox(height: 20),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  _selectedCategory == 'All'
                      ? 'Showing ${_displayRecipes.length} of ${_filteredRecipes.length} recipes'
                      : 'Showing ${_displayRecipes.length} of ${_filteredRecipes.length} ${_selectedCategory.toLowerCase()} recipes',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                ),
              ),
              const SizedBox(height: 12),

              LayoutBuilder(
                builder: (context, constraints) {
                  final crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
                  return Column(
                    children: [
                      // Replace your GridView.builder with this:
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        child: GridView.builder(
                          key: ValueKey(
                            _showMoreRecipes,
                          ), // Important for animation
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 12,
                                mainAxisSpacing: 12,
                                childAspectRatio: constraints.maxWidth > 600
                                    ? 0.7
                                    : 0.65,
                              ),
                          itemCount: _displayRecipes.length,
                          itemBuilder: (context, index) {
                            return AnimatedOpacity(
                              opacity: 1,
                              duration: Duration(
                                milliseconds: 300 + (index * 100),
                              ),
                              child: _buildRecipeCard(_displayRecipes[index]),
                            );
                          },
                        ),
                      ),

                      // Show More/Less Button
                      if (_filteredRecipes.length > _initialRecipeCount)
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: Center(
                            child: ElevatedButton(
                              onPressed: () async {
                                // Show loader
                                LoaderOverlay.show(
                                  context: context,
                                  lottieAsset:
                                      'assets/icons/loader.json', // Your lottie file
                                  message: _showMoreRecipes
                                      ? 'Loading less recipes...'
                                      : 'Loading more recipes...',
                                );

                                // Add a small delay to show the loader
                                await Future.delayed(
                                  const Duration(milliseconds: 1000),
                                );

                                // Update state
                                setState(() {
                                  _showMoreRecipes = !_showMoreRecipes;
                                });

                                // Hide loader
                                LoaderOverlay.hide();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryGreen,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 40,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                _showMoreRecipes
                                    ? 'Show Less'
                                    : 'Show More Recipes',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}

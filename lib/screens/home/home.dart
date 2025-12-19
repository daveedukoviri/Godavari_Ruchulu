import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../theme/app_theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Recipe> _recipes = [
    Recipe(
      title: 'Quinoa Salad',
      chef: 'Liam Levi',
      views: 110000,
      price: 12.99,
      rating: 4.8,
      description:
          'Fresh quinoa salad with vegetables, herbs, and a light vinaigrette dressing.',
      imageUrl:
          'https://cdn.apartmenttherapy.info/image/upload/v1734750008/k/Photo/Recipes/2024-12-dumpling-soup/dumpling-soup-4827.jpg',
    ),
    Recipe(
      title: 'Zhanokoye',
      chef: 'Oliver Leo',
      views: 250000,
      price: 15.99,
      rating: 4.9,
      description: 'Traditional dish with rich flavors and authentic spices.',
      imageUrl:
          'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    ),
    Recipe(
      title: 'Pasta Carbonara',
      chef: 'Henry Chef',
      views: 180000,
      price: 14.50,
      rating: 4.7,
      description:
          'Classic Italian pasta with creamy sauce, bacon, and parmesan.',
      imageUrl:
          'https://images.unsplash.com/photo-1568625365131-079e026a927d?q=80&w=580&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    Recipe(
      title: 'Avocado Toast',
      chef: 'Noah King',
      views: 95000,
      price: 9.99,
      rating: 4.6,
      description: 'Healthy avocado toast with fresh ingredients and herbs.',
      imageUrl:
          'https://plus.unsplash.com/premium_photo-1669557211332-9328425b6f39?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    ),
    Recipe(
      title: 'Chicken Stir Fry',
      chef: 'James Pro',
      views: 320000,
      price: 16.99,
      rating: 4.9,
      description:
          'Delicious stir-fried chicken with fresh vegetables and savory sauce.',
      imageUrl:
          'https://images.unsplash.com/photo-1604909052743-94e838986d24?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    ),
    Recipe(
      title: 'Vegan Buddha Bowl',
      chef: 'Liam Levi',
      views: 150000,
      price: 13.99,
      rating: 4.8,
      description:
          'Nutritious bowl packed with grains, vegetables, and healthy proteins.',
      imageUrl:
          'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    ),
  ];

  final List<Chef> _chefs = [
    Chef(
      name: 'Liam',
      imageUrl:
          'https://t4.ftcdn.net/jpg/01/41/56/45/360_F_141564503_tAcki4lMMh38x9z09kgfuk4iTfV3JcX2.jpg',
    ),
    Chef(
      name: 'Henry',
      imageUrl:
          'https://thumbs.dreamstime.com/b/portrait-cook-white-background-29870501.jpg',
    ),
    Chef(
      name: 'Noah',
      imageUrl:
          'https://thumbs.dreamstime.com/b/female-chef-whisk-circular-logo-design-vector-generative-ai-style-illustration-hat-holding-perfect-394683027.jpg',
    ),
    Chef(
      name: 'Oliver',
      imageUrl:
          'https://t4.ftcdn.net/jpg/01/41/56/45/360_F_141564503_tAcki4lMMh38x9z09kgfuk4iTfV3JcX2.jpg',
    ),
    Chef(
      name: 'James',
      imageUrl:
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTdf21yEk40TalbpFvynfXngZinrbDZvMdXPQ&s',
    ),
  ];

  final List<Category> _categories = [
    Category(title: 'All', isActive: true),
    Category(title: 'Breakfast', isActive: false),
    Category(title: 'Lunch', isActive: false),
    Category(title: 'Snacks', isActive: false),
    Category(title: 'Dinner', isActive: false),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
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
          icon: const Icon(Icons.notifications_outlined, color: Colors.grey),
          onPressed: _onNotificationPressed,
        ),
        IconButton(
          icon: const Icon(Icons.menu, color: Colors.grey),
          onPressed: _onMenuPressed,
        ),
        const SizedBox(width: 8),
      ],
    );
  }

  Widget _buildBody() {
    return SafeArea(
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              _buildSearchField(),
              const SizedBox(height: 24),
              _buildTopChefSection(),
              const SizedBox(height: 24),
              _buildPromoBanner(),
              const SizedBox(height: 30),
              _buildTrendingRecipesSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search beverages or food',
        hintStyle: TextStyle(color: AppTheme.gray),
        prefixIcon: const Icon(Icons.search),
        suffixIcon: const Icon(Icons.tune),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
      ),
      onChanged: _onSearchChanged,
    );
  }

  Widget _buildTopChefSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Top Chef',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            TextButton(
              onPressed: _onSeeAllChefsPressed,
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
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _chefs.length,
            itemBuilder: (context, index) {
              return _buildChefAvatar(_chefs[index]);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      padding: const EdgeInsets.only(top: 16, left: 16, right: 0, bottom: 16),
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
                  onPressed: _onSubscribePressed,
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
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: AppTheme.primaryGreen.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.restaurant_menu,
                  size: 60,
                  color: AppTheme.primaryGreen,
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTrendingRecipesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Trending Recipes',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 16),
        _buildCategoryTabs(),
        const SizedBox(height: 20),
        _buildRecipesGrid(),
        const SizedBox(height: 100),
      ],
    );
  }

  Widget _buildCategoryTabs() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          return _buildCategoryTab(_categories[index]);
        },
      ),
    );
  }

  Widget _buildRecipesGrid() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.7,
      ),
      itemCount: _recipes.length,
      itemBuilder: (context, index) {
        return _buildRecipeCard(_recipes[index]);
      },
    );
  }

  Widget _buildChefAvatar(Chef chef) {
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
              backgroundColor: Colors.grey[300],
              backgroundImage: CachedNetworkImageProvider(chef.imageUrl),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            chef.name,
            style: const TextStyle(fontSize: 12),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTab(Category category) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: ChoiceChip(
        label: Text(category.title),
        selected: category.isActive,
        onSelected: (selected) => _onCategorySelected(category, selected),
        selectedColor: AppTheme.primaryGreen,
        showCheckmark: false,
        backgroundColor: Colors.white,
        labelStyle: TextStyle(
          color: category.isActive ? Colors.white : Colors.black,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(
            color: category.isActive ? Colors.grey[300]! : Colors.grey[300]!,
            width: 1,
          ),
        ),
      ),
    );
  }

  Widget _buildRecipeCard(Recipe recipe) {
    return GestureDetector(
      onTap: () => _showOrderBottomSheet(context, recipe),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withValues(alpha: 0.1),
              spreadRadius: 2,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AspectRatio(
              aspectRatio: 1.2,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
                child: CachedNetworkImage(
                  imageUrl: recipe.imageUrl,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[200],
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(Icons.error, color: Colors.grey),
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      recipe.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      recipe.chef,
                      style: TextStyle(color: AppTheme.gray, fontSize: 11),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${recipe.views.formatViews()} views',
                          style: TextStyle(color: AppTheme.gray, fontSize: 11),
                        ),
                        GestureDetector(
                          onTap: () => _onBookmarkPressed(recipe),
                          child: const Icon(Icons.bookmark_border, size: 18),
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
    );
  }

  void _showOrderBottomSheet(BuildContext context, Recipe recipe) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return _OrderBottomSheet(recipe: recipe);
      },
    );
  }

  // Event handlers
  void _onSearchChanged(String value) {
    // Implement search functionality
  }

  void _onSeeAllChefsPressed() {
    // Navigate to chefs screen
  }

  void _onSubscribePressed() {
    // Navigate to subscription screen
  }

  void _onCategorySelected(Category category, bool selected) {
    setState(() {
      for (var cat in _categories) {
        cat.isActive = false;
      }
      category.isActive = selected;
    });
  }

  void _onBookmarkPressed(Recipe recipe) {
    // Add to bookmarks
  }

  void _onNotificationPressed() {
    // Navigate to notifications
  }

  void _onMenuPressed() {
    // Open menu drawer
  }
}

// Models
class Recipe {
  final String title;
  final String chef;
  final int views;
  final double price;
  final double rating;
  final String description;
  final String imageUrl;

  const Recipe({
    required this.title,
    required this.chef,
    required this.views,
    required this.price,
    required this.rating,
    required this.description,
    required this.imageUrl,
  });
}

class Chef {
  final String name;
  final String imageUrl;

  const Chef({required this.name, required this.imageUrl});
}

class Category {
  final String title;
  bool isActive;

  Category({required this.title, required this.isActive});
}

// Bottom Sheet Widget
class _OrderBottomSheet extends StatefulWidget {
  final Recipe recipe;

  const _OrderBottomSheet({required this.recipe});

  @override
  State<_OrderBottomSheet> createState() => _OrderBottomSheetState();
}

class _OrderBottomSheetState extends State<_OrderBottomSheet> {
  int _quantity = 1;
  String _selectedSize = 'Regular';
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          _buildHandleBar(),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildImageSection(),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildTitleAndPrice(),
                        const SizedBox(height: 4),
                        _buildChefAndRating(),
                        const SizedBox(height: 20),
                        _buildDescription(),
                        const SizedBox(height: 20),
                        _buildSizeSelection(),
                        const SizedBox(height: 20),
                        _buildQuantitySelection(),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildHandleBar() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      width: 40,
      height: 4,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  Widget _buildImageSection() {
    return Stack(
      children: [
        Container(
          height: 250,
          width: double.infinity,
          margin: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: widget.recipe.imageUrl,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Container(
                color: Colors.grey[200],
                child: const Center(
                  child: Icon(Icons.error, color: Colors.grey),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          top: 26,
          right: 26,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Icon(
                _isFavorite ? Icons.favorite : Icons.favorite_border,
                color: _isFavorite ? Colors.red : Colors.grey,
                size: 24,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitleAndPrice() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            widget.recipe.title,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        Text(
          '\$${widget.recipe.price.toStringAsFixed(2)}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryGreen,
          ),
        ),
      ],
    );
  }

  Widget _buildChefAndRating() {
    return Row(
      children: [
        Icon(Icons.person_outline, size: 16, color: AppTheme.gray),
        const SizedBox(width: 4),
        Text(
          widget.recipe.chef,
          style: TextStyle(color: AppTheme.gray, fontSize: 14),
        ),
        const SizedBox(width: 16),
        const Icon(Icons.star, color: Colors.amber, size: 16),
        const SizedBox(width: 4),
        Text(
          widget.recipe.rating.toStringAsFixed(1),
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        const SizedBox(width: 4),
        Text(
          '(${widget.recipe.views.formatViews()} views)',
          style: TextStyle(color: AppTheme.gray, fontSize: 12),
        ),
      ],
    );
  }

  Widget _buildDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Text(
          widget.recipe.description,
          style: TextStyle(color: AppTheme.gray, fontSize: 14, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildSizeSelection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Size',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildSizeOption('Small'),
            const SizedBox(width: 12),
            _buildSizeOption('Regular'),
            const SizedBox(width: 12),
            _buildSizeOption('Large'),
          ],
        ),
      ],
    );
  }

  Widget _buildSizeOption(String size) {
    final isSelected = _selectedSize == size;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedSize = size;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? AppTheme.primaryGreen.withValues(alpha: 0.15)
                : Colors.grey[200],
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isSelected ? AppTheme.primaryGreen : Colors.transparent,
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              size,
              style: TextStyle(
                color: isSelected ? AppTheme.primaryGreen : Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildQuantitySelection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Quantity',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  if (_quantity > 1) {
                    setState(() {
                      _quantity--;
                    });
                  }
                },
                icon: const Icon(Icons.remove),
                color: AppTheme.primaryGreen,
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                child: Text(
                  '$_quantity',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _quantity++;
                  });
                },
                icon: const Icon(Icons.add),
                color: AppTheme.primaryGreen,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            // Add to Cart (outlined)
            Expanded(
              child: ElevatedButton(
                onPressed: _addToCart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppTheme.primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: BorderSide(color: AppTheme.primaryGreen, width: 1),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Add to Cart',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
              ),
            ),

            const SizedBox(width: 16),

            // Buy Now (filled)
            Expanded(
              child: ElevatedButton(
                onPressed: _buyNow,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryGreen,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 2,
                  shadowColor: AppTheme.primaryGreen.withValues(alpha: 0.3),
                ),
                child: const Text(
                  'Buy Now',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addToCart() {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Added $_quantity x ${widget.recipe.title} to cart'),
        backgroundColor: AppTheme.primaryGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _buyNow() {
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Proceeding to checkout: ${widget.recipe.title}'),
        backgroundColor: AppTheme.primaryGreen,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
        duration: const Duration(seconds: 2),
      ),
    );

    // Optional: Navigate to checkout screen
    // Navigator.push(context, MaterialPageRoute(builder: (_) => CheckoutScreen()));
  }
}

// Extension for number formatting
extension NumberFormatting on int {
  String formatViews() {
    if (this >= 1000000) {
      return '${(this / 1000000).toStringAsFixed(1)}M';
    } else if (this >= 1000) {
      return '${(this / 1000).toStringAsFixed(1)}K';
    }
    return toString();
  }
}

// Add to pubspec.yaml dependencies:
// cached_network_image: ^3.3.0

import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';
import '../receiptdetails/receiptdetails.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Map<String, String>> _recipes = [
    {
      'title': 'Quinoa Salad',
      'chef': 'Liam Levi',
      'views': '110K views',
      'price': '\$12.99',
      'isVeg': 'true',
      'rating': '4.8',
      'description':
          'Fresh quinoa salad with vegetables, herbs, and a light vinaigrette dressing.',
      'imageUrl':
          'https://cdn.apartmenttherapy.info/image/upload/v1734750008/k/Photo/Recipes/2024-12-dumpling-soup/dumpling-soup-4827.jpg',
    },
    {
      'title': 'Zhanokoye',
      'chef': 'Oliver Leo',
      'views': '250K views',
      'price': '\$15.99',
      'isVeg': 'false',
      'rating': '4.9',
      'description': 'Traditional dish with rich flavors and authentic spices.',
      'imageUrl':
          'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    },
    {
      'title': 'Pasta Carbonara',
      'chef': 'Henry Chef',
      'views': '180K views',
      'price': '\$14.50',
      'isVeg': 'true',
      'rating': '4.7',
      'description':
          'Classic Italian pasta with creamy sauce, bacon, and parmesan.',
      'imageUrl':
          'https://images.unsplash.com/photo-1568625365131-079e026a927d?q=80&w=580&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      'title': 'Avocado Toast',
      'chef': 'Noah King',
      'views': '95K views',
      'price': '\$9.99',
      'isVeg': 'true',
      'rating': '4.6',
      'description': 'Healthy avocado toast with fresh ingredients and herbs.',
      'imageUrl':
          'https://plus.unsplash.com/premium_photo-1669557211332-9328425b6f39?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      'title': 'Chicken Stir Fry',
      'chef': 'James Pro',
      'views': '320K views',
      'price': '\$16.99',
      'isVeg': 'false',
      'rating': '4.9',
      'description':
          'Delicious stir-fried chicken with fresh vegetables and savory sauce.',
      'imageUrl':
          'https://images.unsplash.com/photo-1604909052743-94e838986d24?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    },
    {
      'title': 'Vegan Buddha Bowl',
      'chef': 'Liam Levi',
      'views': '150K views',
      'price': '\$13.99',
      'isVeg': 'true',
      'rating': '4.8',
      'description':
          'Nutritious bowl packed with grains, vegetables, and healthy proteins.',
      'imageUrl':
          'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    },
  ];

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

  Widget _buildCategoryTab(String title, bool isActive) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Chip(
        label: Text(title),
        backgroundColor: isActive ? AppTheme.primaryGreen : Colors.white,
        labelStyle: TextStyle(color: isActive ? Colors.white : Colors.black),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      ),
    );
  }

  // Define _badge helper method before using it
  Widget _badge({required IconData icon, required String text}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 4),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppTheme.primaryGreen),
          const SizedBox(width: 4),
          Text(
            text,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppTheme.primaryDark,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeCard(
    String title,
    String chef,
    String views,
    String imageUrl,
    Map<String, String> recipe,
  ) {
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
          borderRadius: BorderRadius.circular(20), // Smaller radius
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
            // ================= IMAGE =================
            SizedBox(
              height: 125, // Reduced for better fit
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.network(
                      imageUrl,

                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Container(
                        color: Colors.grey[200],
                        child: const Center(
                          child: Icon(Icons.restaurant, color: Colors.grey),
                        ),
                      ),
                    ),

                    // Gradient overlay at bottom only
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

                    // Rating at bottom left
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
                              recipe['rating']!,
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

                    // Price at bottom right
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
                          recipe['price']!,
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

            // ================= CONTENT =================
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title - Single line for safety
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.primaryDark,
                    ),
                  ),
                  const SizedBox(height: 4),

                  // Chef name
                  Text(
                    chef,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: 12, color: AppTheme.gray),
                  ),
                  const SizedBox(height: 6),

                  // Views and duration
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
                            views,
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
                          '30 min',
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

            // ================= BOTTOM BAR =================
            Container(
              height: 36,
              decoration: BoxDecoration(
                color: Colors.grey[50],
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
                    // Likes
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

                    // Difficulty
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
                          // Simple elegant dot
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

                    // Share
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.grey),
            onPressed: () {},
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
              TextField(
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
              ),
              const SizedBox(height: 24),

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
              const SizedBox(height: 16),

              SizedBox(
                height: 40,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    _buildCategoryTab('All', true),
                    _buildCategoryTab('Breakfast', false),
                    _buildCategoryTab('Lunch', false),
                    _buildCategoryTab('Snacks', false),
                    _buildCategoryTab('Dinner', false),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Use SliverGridDelegateWithMaxCrossAxisExtent for better responsiveness
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200, // Maximum width for each card
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.67, // Slightly taller to avoid overflow
                ),
                itemCount: _recipes.length,
                itemBuilder: (context, index) {
                  final recipe = _recipes[index];
                  return _buildRecipeCard(
                    recipe['title']!,
                    recipe['chef']!,
                    recipe['views']!,
                    recipe['imageUrl']!,
                    recipe,
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

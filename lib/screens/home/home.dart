import 'package:flutter/material.dart';
import '../../theme/app_theme.dart';

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
      'imageUrl':
          'https://cdn.apartmenttherapy.info/image/upload/v1734750008/k/Photo/Recipes/2024-12-dumpling-soup/dumpling-soup-4827.jpg',
    },
    {
      'title': 'Zhanokoye',
      'chef': 'Oliver Leo',
      'views': '250K views',
      'imageUrl':
          'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    },
    {
      'title': 'Pasta Carbonara',
      'chef': 'Henry Chef',
      'views': '180K views',
      'imageUrl':
          'https://images.unsplash.com/photo-1568625365131-079e026a927d?q=80&w=580&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      'title': 'Avocado Toast',
      'chef': 'Noah King',
      'views': '95K views',
      'imageUrl':
          'https://plus.unsplash.com/premium_photo-1669557211332-9328425b6f39?q=80&w=387&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
    },
    {
      'title': 'Chicken Stir Fry',
      'chef': 'James Pro',
      'views': '320K views',
      'imageUrl':
          'https://images.unsplash.com/photo-1604909052743-94e838986d24?ixlib=rb-4.0.3&auto=format&fit=crop&w=800&q=80',
    },
    {
      'title': 'Vegan Buddha Bowl',
      'chef': 'Liam Levi',
      'views': '150K views',
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

  Widget _buildRecipeCard(
    String title,
    String chef,
    String views,
    String imageUrl,
  ) {
    return Container(
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
        mainAxisSize: MainAxisSize.min, // Important: don't expand
        children: [
          // Image container with fixed aspect ratio
          AspectRatio(
            aspectRatio: 1.2, // Slightly taller than square
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: Colors.grey[200],
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[200],
                    child: const Center(
                      child: Icon(Icons.error, color: Colors.grey),
                    ),
                  );
                },
              ),
            ),
          ),
          // Content with flexible sizing
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14, // Slightly smaller
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    chef,
                    style: TextStyle(color: AppTheme.gray, fontSize: 11),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        views,
                        style: TextStyle(color: AppTheme.gray, fontSize: 11),
                      ),
                      GestureDetector(
                        onTap: () {},
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
              // Search Bar
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

              // Top Chef
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Top Chef',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
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

              // Premium Banner
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

              // Trending Recipes
              const Text(
                'Trending Recipes',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 16),

              // Category Tabs
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

              // Recipe Grid - Using GridView with IntrinsicHeight
              LayoutBuilder(
                builder: (context, constraints) {
                  return GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.7, // Adjusted for better fit
                    ),
                    itemCount: _recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = _recipes[index];
                      return _buildRecipeCard(
                        recipe['title']!,
                        recipe['chef']!,
                        recipe['views']!,
                        recipe['imageUrl']!,
                      );
                    },
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
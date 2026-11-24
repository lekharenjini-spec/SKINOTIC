 import 'package:material_ui/material_ui.dart';
 

import 'analyzer_page.dart';
import 'ingredient_search_page.dart';
import 'photo_analysis_page.dart';
import 'product_lookup_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  int selectedIndex = 0;

  final List<String> categories = [
    'All',
    'Cleanser',
    'Moisturizer',
    'Serum',
    'Sunscreen',
  ];

  String selectedCategory = 'All';

  final List<Map<String, String>> products = [
    {
      'name': 'Gentle Cleanser',
      'category': 'Cleanser',
      'description': 'A gentle daily cleansing product',
    },
    {
      'name': 'Hydrating Moisturizer',
      'category': 'Moisturizer',
      'description': 'A product designed to moisturize skin',
    },
    {
      'name': 'Vitamin C Serum',
      'category': 'Serum',
      'description': 'A serum containing vitamin C',
    },
    {
      'name': 'Daily Sunscreen',
      'category': 'Sunscreen',
      'description': 'A product designed for UV protection',
    },
  ];

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void openPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void openProductLookup() {
    openPage(const ProductLookupPage());
  }

  void openPhotoAnalysis() {
    openPage(const PhotoAnalysisPage());
  }

  void openManualAnalyzer() {
    openPage(const AnalyzerPage());
  }

  void openIngredientSearch() {
    openPage(const IngredientSearchPage());
  }

  void handleSearch() {
    openProductLookup();
  }

  @override
  Widget build(BuildContext context) {
    final filteredProducts = products.where((product) {
      final matchesCategory = selectedCategory == 'All' ||
          product['category'] == selectedCategory;

      final query = searchController.text.toLowerCase();

      final matchesSearch = product['name']!
              .toLowerCase()
              .contains(query) ||
          product['category']!.toLowerCase().contains(query);

      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F1ED),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F1ED),
        elevation: 0,
        title: const Text(
          'SKINOTIC',
          style: TextStyle(
            color: Color(0xFF795548),
            fontSize: 25,
            fontWeight: FontWeight.bold,
            letterSpacing: 2,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.person_outline,
              color: Color(0xFF795548),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile feature coming soon!'),
                ),
              );
            },
          ),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(18),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // WELCOME SECTION

              const Text(
                'Hello!',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF594238),
                ),
              ),

              const SizedBox(height: 5),

              const Text(
                'Understand what goes into your cosmetics.',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.brown,
                ),
              ),

              const SizedBox(height: 22),

              // PRODUCT SEARCH

              TextField(
                controller: searchController,
                onChanged: (value) {
                  setState(() {});
                },
                onSubmitted: (value) {
                  handleSearch();
                },
                decoration: InputDecoration(
                  hintText: 'Search for a cosmetic product...',
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.arrow_forward),
                    onPressed: handleSearch,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // MAIN ANALYSIS BANNER

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8D5CA),
                  borderRadius: BorderRadius.circular(22),
                ),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const Icon(
                      Icons.spa_outlined,
                      size: 38,
                      color: Color(0xFF795548),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Know Your Ingredients',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF594238),
                      ),
                    ),

                    const SizedBox(height: 7),

                    const Text(
                      'Explore cosmetic ingredients, their functions, '
                      'benefits and possible concerns.',
                      style: TextStyle(
                        fontSize: 14,
                        color: Color(0xFF594238),
                      ),
                    ),

                    const SizedBox(height: 18),

                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: openPhotoAnalysis,
                        icon: const Icon(Icons.camera_alt_outlined),
                        label: const Text(
                          'Analyse Ingredients from Photo',
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF795548),
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: openManualAnalyzer,
                        icon: const Icon(Icons.edit_note),
                        label: const Text(
                          'Enter Ingredients Manually',
                        ),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF795548),
                          side: const BorderSide(
                            color: Color(0xFF795548),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 27),

              // QUICK FEATURES

              const Text(
                'Explore SKINOTIC',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF594238),
                ),
              ),

              const SizedBox(height: 14),

              Row(
                children: [

                  Expanded(
                    child: featureCard(
                      icon: Icons.search,
                      title: 'Product Lookup',
                      subtitle: 'Search by product name',
                      onTap: openProductLookup,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: featureCard(
                      icon: Icons.science_outlined,
                      title: 'Ingredient Guide',
                      subtitle: 'Explore ingredient details',
                      onTap: openIngredientSearch,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 27),

              // CATEGORIES

              const Text(
                'Categories',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF594238),
                ),
              ),

              const SizedBox(height: 13),

              SizedBox(
                height: 42,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,

                  itemBuilder: (context, index) {
                    final category = categories[index];

                    final isSelected =
                        selectedCategory == category;

                    return Padding(
                      padding: const EdgeInsets.only(right: 9),

                      child: ChoiceChip(
                        label: Text(category),
                        selected: isSelected,
                        onSelected: (selected) {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                        selectedColor: const Color(0xFFD8BBAE),
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(
                          color: isSelected
                              ? const Color(0xFF594238)
                              : Colors.brown,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 18),

              // SAMPLE PRODUCTS

              const Text(
                'Explore Products',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF594238),
                ),
              ),

              const SizedBox(height: 13),

              if (filteredProducts.isEmpty)
                const Padding(
                  padding: EdgeInsets.all(18),
                  child: Center(
                    child: Text('No matching sample products found.'),
                  ),
                )
              else
                ...filteredProducts.map((product) {
                  return Card(
                    color: Colors.white,
                    elevation: 1,
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),

                    child: ListTile(
                      leading: const CircleAvatar(
                        backgroundColor: Color(0xFFE8D5CA),
                        child: Icon(
                          Icons.spa_outlined,
                          color: Color(0xFF795548),
                        ),
                      ),

                      title: Text(
                        product['name']!,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF594238),
                        ),
                      ),

                      subtitle: Text(
                        '${product['category']} • '
                        '${product['description']}',
                      ),

                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),

                      onTap: openProductLookup,
                    ),
                  );
                }),

              const SizedBox(height: 20),

              // INGREDIENT SIDE EFFECTS

              Container(
                padding: const EdgeInsets.all(17),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0E3DC),
                  borderRadius: BorderRadius.circular(18),
                ),

                child: Row(
                  children: [

                    const Icon(
                      Icons.info_outline,
                      size: 35,
                      color: Color(0xFF795548),
                    ),

                    const SizedBox(width: 13),

                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Know an Ingredient?',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF594238),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Search its functions and possible side effects.',
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),

                    IconButton(
                      onPressed: openIngredientSearch,
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Color(0xFF795548),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              const Center(
                child: Text(
                  'SKINOTIC • Understand Your Cosmetics',
                  style: TextStyle(
                    color: Colors.brown,
                    fontSize: 12,
                  ),
                ),
              ),

              const SizedBox(height: 15),
            ],
          ),
        ),
      ),

      // BOTTOM NAVIGATION

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: const Color(0xFF795548),
        unselectedItemColor: Colors.grey,

        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });

          if (index == 1) {
            openManualAnalyzer();
          } else if (index == 2) {
            openIngredientSearch();
          } else if (index == 3) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Saved products feature coming soon!'),
              ),
            );
          }
        },

        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics_outlined),
            label: 'Analyze',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.science_outlined),
            label: 'Ingredients',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_outline),
            label: 'Saved',
          ),
        ],
      ),
    );
  }

  // REUSABLE FEATURE CARD

  Widget featureCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(17),

      child: Container(
        height: 145,
        padding: const EdgeInsets.all(14),

        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(
            color: const Color(0xFFE8D5CA),
          ),
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Icon(
              icon,
              size: 30,
              color: const Color(0xFF795548),
            ),

            const SizedBox(height: 10),

            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xFF594238),
              ),
            ),

            const SizedBox(height: 5),

            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 11,
                color: Colors.brown,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


import 'dart:convert';

import 'package:material_ui/material_ui.dart';
import 'package:http/http.dart' as http;

import 'ingredient_data.dart';

class ProductLookupPage extends StatefulWidget {
  const ProductLookupPage({super.key});

  @override
  State<ProductLookupPage> createState() => _ProductLookupPageState();
}

class _ProductLookupPageState extends State<ProductLookupPage> {
  final TextEditingController searchController =
      TextEditingController();

  bool isLoading = false;

  List<Map<String, dynamic>> searchResults = [];

  Map<String, dynamic>? selectedProduct;

  String errorMessage = '';

  static const Color primaryColor = Color(0xFF967365);
  static const Color darkColor = Color(0xFF49372F);
  static const Color backgroundColor = Color(0xFFF7EEE9);

  // SEARCH PRODUCTS BY NAME

  Future<void> searchProducts() async {
    final query = searchController.text.trim();

    if (query.isEmpty) {
      setState(() {
        errorMessage = 'Please enter a product name.';
        searchResults = [];
        selectedProduct = null;
      });
      return;
    }

    setState(() {
      isLoading = true;
      errorMessage = '';
      searchResults = [];
      selectedProduct = null;
    });

    try {
      final uri = Uri.https(
        'world.openbeautyfacts.org',
        '/cgi/search.pl',
        {
          'search_terms': query,
          'search_simple': '1',
          'action': 'process',
          'json': '1',
          'page_size': '15',
          'fields':
              'product_name,brands,ingredients_text,image_url',
        },
      );

      final response = await http.get(uri);

      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final products = data['products'] as List? ?? [];

        final results = products
            .where((item) =>
                item is Map &&
                item['product_name'] != null &&
                item['product_name'].toString().trim().isNotEmpty)
            .map((item) => Map<String, dynamic>.from(item))
            .toList();

        setState(() {
          searchResults = results;

          if (searchResults.isEmpty) {
            errorMessage =
                'No products found. Try another product name.';
          }
        });
      } else {
        setState(() {
          errorMessage =
              'Could not connect to the product database.';
        });
      }
    } catch (e) {
      if (!mounted) return;

      setState(() {
        errorMessage =
            'Something went wrong. Check your internet connection.';
      });
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // SELECT A PRODUCT

  void showProduct(Map<String, dynamic> product) {
    setState(() {
      selectedProduct = product;
      errorMessage = '';
    });
  }

  // SAFELY READ API VALUES

  String getText(dynamic value) {
    if (value == null) return '';
    return value.toString();
  }

  // FIND INGREDIENT IN OUR DATABASE

  CosmeticIngredient? findIngredient(String name) {
    final searchName = name.trim().toLowerCase();

    for (final ingredient in cosmeticIngredients) {
      if (ingredient.inciName.toLowerCase() == searchName) {
        return ingredient;
      }

      for (final commonName in ingredient.commonNames) {
        if (commonName.toLowerCase() == searchName) {
          return ingredient;
        }
      }
    }

    return null;
  }

  // SHOW INGREDIENT ANALYSIS

  Widget buildIngredientDetails(String ingredientText) {
    if (ingredientText.trim().isEmpty) {
      return const Card(
        color: Colors.white,
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text(
            'The product database does not have an ingredient '
            'list for this product. Please check the product packaging.',
          ),
        ),
      );
    }

    final names = ingredientText
        .split(RegExp(r'[,;\n]+'))
        .map((name) => name.trim())
        .where((name) => name.isNotEmpty)
        .toList();

    return Column(
      children: names.map((name) {
        final ingredient = findIngredient(name);

        if (ingredient == null) {
          return Card(
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 10),
            child: ListTile(
              leading: const Icon(
                Icons.help_outline,
                color: primaryColor,
              ),
              title: Text(
                name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                'Details are not available in the SKINOTIC '
                'database yet.',
              ),
            ),
          );
        }

        return Card(
          color: Colors.white,
          margin: const EdgeInsets.only(bottom: 12),
          child: ExpansionTile(
            leading: const Icon(
              Icons.science_outlined,
              color: primaryColor,
            ),
            title: Text(
              ingredient.inciName,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: darkColor,
              ),
            ),
            subtitle: Text(ingredient.category),
            childrenPadding: const EdgeInsets.all(15),
            expandedCrossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              detail(
                'Description',
                ingredient.description,
              ),
              detail(
                'Functions',
                ingredient.functions.join(', '),
              ),
              detail(
                'Benefits',
                ingredient.benefits,
              ),
              detail(
                'Possible Concerns',
                ingredient.possibleConcerns,
              ),
              detail(
                'Precautions',
                ingredient.precautions,
              ),
              detail(
                'Sources',
                ingredient.sources.join(', '),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  // REUSABLE DETAIL WIDGET

  Widget detail(String heading, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: darkColor,
            ),
          ),
          const SizedBox(height: 5),
          Text(value),
        ],
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final product = selectedProduct;

    final productName = product == null
        ? ''
        : getText(product['product_name']);

    final brand = product == null
        ? ''
        : getText(product['brands']);

    final imageUrl = product == null
        ? ''
        : getText(product['image_url']);

    final ingredients = product == null
        ? ''
        : getText(product['ingredients_text']);

    return Scaffold(
      backgroundColor: backgroundColor,

      appBar: AppBar(
        title: const Text(
          'Product Ingredient Lookup',
          style: TextStyle(
            color: darkColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: backgroundColor,
        iconTheme: const IconThemeData(
          color: darkColor,
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              'Find what is inside your product!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: darkColor,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Search for a cosmetic product and explore '
              'its ingredients.',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 22),

            // SEARCH FIELD

            TextField(
              controller: searchController,
              onSubmitted: (_) => searchProducts(),
              decoration: InputDecoration(
                hintText: 'Enter product name',
                prefixIcon: const Icon(
                  Icons.search,
                  color: primaryColor,
                ),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 13),

            // SEARCH BUTTON

            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: isLoading ? null : searchProducts,
                icon: const Icon(Icons.search),
                label: const Text('Search Product'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(15),
                ),
              ),
            ),

            const SizedBox(height: 20),

            if (isLoading)
              const Center(
                child: CircularProgressIndicator(
                  color: primaryColor,
                ),
              ),

            // ERROR MESSAGE

            if (errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  errorMessage,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
              ),

            // SEARCH RESULTS

            if (searchResults.isNotEmpty &&
                selectedProduct == null) ...[
              const Text(
                'Search Results',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: darkColor,
                ),
              ),

              const SizedBox(height: 12),

              ...searchResults.map((item) {
                final name = getText(item['product_name']);
                final brandName = getText(item['brands']);
                final image = getText(item['image_url']);

                return Card(
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 12),

                  child: ListTile(
                    leading: image.isNotEmpty
                        ? Image.network(
                            image,
                            width: 48,
                            height: 55,
                            fit: BoxFit.contain,
                            errorBuilder: (_, _, _) =>
                                const Icon(
                              Icons.spa_outlined,
                              color: primaryColor,
                            ),
                          )
                        : const Icon(
                            Icons.spa_outlined,
                            color: primaryColor,
                          ),

                    title: Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    subtitle: Text(
                      brandName.isEmpty
                          ? 'Brand not available'
                          : brandName,
                    ),

                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),

                    onTap: () => showProduct(item),
                  ),
                );
              }),
            ],

            // SELECTED PRODUCT DETAILS

            if (product != null) ...[
              const Divider(height: 30),

              Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (imageUrl.isNotEmpty)
                        Center(
                          child: Image.network(
                            imageUrl,
                            height: 170,
                            fit: BoxFit.contain,
                            errorBuilder: (_, _, _) =>
                                const Icon(
                              Icons.spa_outlined,
                              size: 65,
                              color: primaryColor,
                            ),
                          ),
                        ),

                      const SizedBox(height: 12),

                      Text(
                        productName,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: darkColor,
                        ),
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Brand: ${brand.isEmpty ? 'Not available' : brand}',
                      ),

                      const SizedBox(height: 10),

                      TextButton.icon(
                        onPressed: () {
                          setState(() {
                            selectedProduct = null;
                          });
                        },
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Back to search results'),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 22),

              const Text(
                'Ingredient Analysis',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: darkColor,
                ),
              ),

              const SizedBox(height: 12),

              buildIngredientDetails(ingredients),

              const SizedBox(height: 15),

              const Text(
                'Note: Ingredient information is educational. '
                'Database entries may be incomplete. Product '
                'information should always be checked against '
                'the actual packaging.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black54,
                ),
              ),
            ],

            const SizedBox(height: 25),

            const Center(
              child: Text(
                'SKINOTIC • Understand Your Cosmetics',
                style: TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

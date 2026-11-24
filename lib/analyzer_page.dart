 import 'package:material_ui/material_ui.dart';

import 'ingredient_data.dart';

class AnalyzerPage extends StatefulWidget {
  const AnalyzerPage({super.key});

  @override
  State<AnalyzerPage> createState() => _AnalyzerPageState();
}

class _AnalyzerPageState extends State<AnalyzerPage> {
  final TextEditingController productController =
      TextEditingController();

  final TextEditingController ingredientController =
      TextEditingController();

  List<CosmeticIngredient> foundIngredients = [];
  List<String> unknownIngredients = [];

  // Find an ingredient in our central database
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

  // Analyze the entered ingredients
  void analyzeIngredients() {
    final enteredText = ingredientController.text.trim();

    if (enteredText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter some ingredients first.'),
        ),
      );
      return;
    }

    final names = enteredText
        .split(RegExp(r'[,;\n]+'))
        .map((name) => name.trim())
        .where((name) => name.isNotEmpty)
        .toList();

    final List<CosmeticIngredient> matched = [];
    final List<String> unmatched = [];

    for (final name in names) {
      final ingredient = findIngredient(name);

      if (ingredient != null) {
        matched.add(ingredient);
      } else {
        unmatched.add(name);
      }
    }

    setState(() {
      foundIngredients = matched;
      unknownIngredients = unmatched;
    });
  }

  @override
  void dispose() {
    productController.dispose();
    ingredientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const backgroundColor = Color(0xFFF7EEE9);
    const primaryColor = Color(0xFF967365);
    const darkColor = Color(0xFF49372F);

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          'Ingredient Analyzer',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: darkColor,
          ),
        ),
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: darkColor),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Discover what is inside your product!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: darkColor,
              ),
            ),

            const SizedBox(height: 20),

            // Product name
            TextField(
              controller: productController,
              decoration: InputDecoration(
                labelText: 'Product Name',
                hintText: 'Enter the product name',
                prefixIcon: const Icon(Icons.spa),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 15),

            // Ingredient list
            TextField(
              controller: ingredientController,
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Ingredients',
                hintText:
                    'Example: Glycerin, Niacinamide, Panthenol',
                alignLabelWithHint: true,
                prefixIcon: const Icon(Icons.science),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Analyze button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: analyzeIngredients,
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Analyze Ingredients',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),

            const SizedBox(height: 25),

            // Results
            if (foundIngredients.isNotEmpty ||
                unknownIngredients.isNotEmpty) ...[
              Text(
                'Analysis Results',
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: darkColor,
                ),
              ),

              if (productController.text.trim().isNotEmpty) ...[
                const SizedBox(height: 5),
                Text(
                  'Product: ${productController.text.trim()}',
                  style: const TextStyle(color: darkColor),
                ),
              ],

              const SizedBox(height: 15),

              ...foundIngredients.map(
                (ingredient) => Card(
                  color: Colors.white,
                  margin: const EdgeInsets.only(bottom: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ingredient.inciName,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: darkColor,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          ingredient.category,
                          style: const TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        const Divider(height: 25),

                        detailSection(
                          'Description',
                          ingredient.description,
                        ),

                        detailSection(
                          'Functions',
                          ingredient.functions.join(', '),
                        ),

                        detailSection(
                          'Benefits',
                          ingredient.benefits,
                        ),

                        detailSection(
                          'Possible Concerns',
                          ingredient.possibleConcerns,
                        ),

                        detailSection(
                          'Precautions',
                          ingredient.precautions,
                        ),

                        detailSection(
                          'Information Sources',
                          ingredient.sources.join(', '),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              if (unknownIngredients.isNotEmpty) ...[
                const SizedBox(height: 10),

                const Text(
                  'Ingredients Not Found',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: darkColor,
                  ),
                ),

                const SizedBox(height: 8),

                ...unknownIngredients.map(
                  (name) => ListTile(
                    leading: const Icon(
                      Icons.help_outline,
                      color: primaryColor,
                    ),
                    title: Text(name),
                    subtitle: const Text(
                      'Not available in our database yet.',
                    ),
                  ),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  // Reusable section for ingredient information
  Widget detailSection(String heading, String information) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            heading,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            information,
            style: const TextStyle(
              fontSize: 14,
              height: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

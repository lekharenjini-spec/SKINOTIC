
import 'package:material_ui/material_ui.dart';
import 'ingredient_data.dart';
import 'product_service.dart';

class ProductDetailsPage extends StatelessWidget {
  final CosmeticProduct product;

  const ProductDetailsPage({
    super.key,
    required this.product,
  });

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

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF967365);
    const darkColor = Color(0xFF49372F);

    final ingredientNames = product.ingredients
        .split(RegExp(r'[,;\n]+'))
        .map((name) => name.trim())
        .where((name) => name.isNotEmpty)
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF7EEE9),
      appBar: AppBar(
        title: const Text('Product Details'),
        backgroundColor: const Color(0xFFF7EEE9),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (product.imageUrl.isNotEmpty)
                      Image.network(
                        product.imageUrl,
                        height: 160,
                        width: double.infinity,
                        fit: BoxFit.contain,
                        errorBuilder: (_, _, _) =>
                            const Icon(Icons.spa, size: 60),
                      ),

                    Text(
                      product.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: darkColor,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text('Brand: ${product.brand}'),

                    Text('Barcode: ${product.barcode}'),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              'Ingredient Analysis',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
                color: darkColor,
              ),
            ),

            const SizedBox(height: 12),

            if (ingredientNames.isEmpty)
              const Card(
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Text(
                    'No ingredient list is available for this product.',
                  ),
                ),
              ),

            ...ingredientNames.map((name) {
              final ingredient = findIngredient(name);

              return Card(
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 14),

                child: Padding(
                  padding: const EdgeInsets.all(15),

                  child: ingredient == null
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(height: 6),
                            const Text(
                              'This ingredient is not yet in the SKINOTIC database.',
                            ),
                          ],
                        )
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              ingredient.inciName,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: darkColor,
                              ),
                            ),

                            Text(
                              ingredient.category,
                              style: const TextStyle(
                                color: primaryColor,
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                            const Divider(height: 22),

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
                          ],
                        ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget detail(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          Text(value),
        ],
      ),
    );
  }
}

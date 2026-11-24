
import 'package:material_ui/material_ui.dart';

class IngredientSearchPage extends StatefulWidget {
  const IngredientSearchPage({super.key});

  @override
  State<IngredientSearchPage> createState() =>
      _IngredientSearchPageState();
}

class _IngredientSearchPageState
    extends State<IngredientSearchPage> {

  final TextEditingController searchController =
      TextEditingController();

  final Color green = const Color(0xFF40594A);
  final Color cream = const Color(0xFFF5F2EA);

  String searchText = '';

  // INGREDIENT DATABASE

  final Map<String, Map<String, String>> ingredients = {

    'Niacinamide': {
      'function': 'Skin conditioning and barrier support.',
      'benefits':
          'May help improve uneven skin tone, support the skin barrier and reduce the appearance of excess oil.',
      'sideEffects':
          'Some people may experience redness, itching, burning or irritation.',
      'precautions':
          'Introduce gradually and stop using it if persistent irritation occurs.',
    },

    'Salicylic Acid': {
      'function': 'Beta hydroxy acid (BHA) exfoliant.',
      'benefits':
          'Helps exfoliate inside pores and can improve the appearance of clogged pores and acne.',
      'sideEffects':
          'May cause dryness, peeling, redness or irritation.',
      'precautions':
          'Avoid overusing exfoliating products. Follow the product instructions.',
    },

    'Hyaluronic Acid': {
      'function': 'Humectant that attracts water.',
      'benefits':
          'Helps the skin retain moisture and feel hydrated.',
      'sideEffects':
          'Usually well tolerated, but irritation or an allergic reaction is possible.',
      'precautions':
          'Check the complete product formulation if irritation occurs.',
    },

    'Glycerin': {
      'function': 'Humectant and moisturizing ingredient.',
      'benefits':
          'Attracts water and helps maintain skin hydration.',
      'sideEffects':
          'Rarely, some individuals may experience irritation or sensitivity.',
      'precautions':
          'Use according to the product instructions.',
    },

    'Vitamin C': {
      'function': 'Antioxidant.',
      'benefits':
          'Helps protect against oxidative stress and can improve the appearance of uneven skin tone.',
      'sideEffects':
          'Some formulations may cause stinging, redness or irritation.',
      'precautions':
          'Introduce gradually and use sunscreen during daytime skincare.',
    },

    'Retinol': {
      'function': 'Vitamin A derivative.',
      'benefits':
          'Can support skin cell turnover and improve the appearance of certain signs of skin ageing.',
      'sideEffects':
          'May cause dryness, redness, peeling and irritation.',
      'precautions':
          'Can be unsuitable for younger users without professional guidance. Avoid during pregnancy.',
    },

    'Fragrance': {
      'function': 'Provides scent to cosmetic products.',
      'benefits':
          'Improves the fragrance of the product.',
      'sideEffects':
          'Can cause irritation or allergic contact reactions in sensitive individuals.',
      'precautions':
          'People with fragrance sensitivity may prefer fragrance-free products.',
    },

    'Ceramides': {
      'function': 'Skin barrier supporting lipids.',
      'benefits':
          'Help maintain the skin barrier and reduce moisture loss.',
      'sideEffects':
          'Generally well tolerated; reactions to other ingredients in the formulation are possible.',
      'precautions':
          'Check the full ingredient list if a reaction occurs.',
    },

    'Aloe Vera': {
      'function': 'Skin conditioning ingredient.',
      'benefits':
          'Commonly used for its soothing and moisturizing properties.',
      'sideEffects':
          'May cause irritation or allergic reactions in some individuals.',
      'precautions':
          'Check product suitability and discontinue if irritation occurs.',
    },

    'Benzoyl Peroxide': {
      'function': 'Topical acne-treatment ingredient.',
      'benefits':
          'Helps reduce acne-causing bacteria and treat acne.',
      'sideEffects':
          'Can cause dryness, redness, peeling and irritation.',
      'precautions':
          'Can bleach fabrics. Follow product directions and seek professional advice if needed.',
    },

  };

  // SEARCH FUNCTION

  List<String> get searchResults {

    if (searchText.isEmpty) {
      return ingredients.keys.toList();
    }

    return ingredients.keys.where((name) {

      return name.toLowerCase().contains(
        searchText.toLowerCase(),
      );

    }).toList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  // INGREDIENT DETAILS

  void showIngredientDetails(String name) {

    final details = ingredients[name]!;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: cream,

      builder: (context) {

        return Padding(

          padding: const EdgeInsets.all(24),

          child: SingleChildScrollView(

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                Center(
                  child: Container(
                    width: 45,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                Text(
                  name,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: green,
                  ),
                ),

                const SizedBox(height: 20),

                buildDetail(
                  'Function',
                  details['function']!,
                  Icons.science_outlined,
                ),

                buildDetail(
                  'Benefits',
                  details['benefits']!,
                  Icons.spa_outlined,
                ),

                buildDetail(
                  'Possible Side Effects',
                  details['sideEffects']!,
                  Icons.warning_amber_outlined,
                ),

                buildDetail(
                  'Precautions',
                  details['precautions']!,
                  Icons.health_and_safety_outlined,
                ),

                const SizedBox(height: 12),

                const Text(
                  'Information is general and may vary depending '
                  'on concentration, formulation and individual '
                  'skin sensitivity. This is not a medical diagnosis.',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),

                const SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,

                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },

                    style: ElevatedButton.styleFrom(
                      backgroundColor: green,
                      foregroundColor: Colors.white,
                    ),

                    child: const Text('CLOSE'),
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }

  // REUSABLE DETAIL CARD

  Widget buildDetail(
    String title,
    String description,
    IconData icon,
  ) {

    return Container(

      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Row(
            children: [

              Icon(
                icon,
                color: green,
              ),

              const SizedBox(width: 10),

              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: green,
                  ),
                ),
              ),

            ],
          ),

          const SizedBox(height: 10),

          Text(
            description,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: Colors.black87,
            ),
          ),

        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: cream,

      appBar: AppBar(
        title: const Text('Ingredient Library'),
        backgroundColor: cream,
        foregroundColor: green,
        elevation: 0,
      ),

      body: SafeArea(

        child: Padding(

          padding: const EdgeInsets.all(20),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [

              Text(
                'Explore Ingredients',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: green,
                ),
              ),

              const SizedBox(height: 8),

              const Text(
                'Discover the functions, benefits and possible '
                'side effects of skincare ingredients.',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 22),

              // SEARCH BAR

              TextField(

                controller: searchController,

                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                },

                decoration: InputDecoration(

                  hintText: 'Search an ingredient...',

                  prefixIcon: const Icon(Icons.search),

                  suffixIcon: IconButton(
                    icon: const Icon(Icons.clear),

                    onPressed: () {
                      searchController.clear();

                      setState(() {
                        searchText = '';
                      });
                    },
                  ),

                  filled: true,
                  fillColor: Colors.white,

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Text(
                'Available Ingredients',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: green,
                ),
              ),

              const SizedBox(height: 12),

              Expanded(

                child: searchResults.isEmpty

                    ? const Center(
                        child: Text(
                          'Ingredient not found.\nTry another name.',
                          textAlign: TextAlign.center,
                        ),
                      )

                    : ListView.builder(

                        itemCount: searchResults.length,

                        itemBuilder: (context, index) {

                          String name = searchResults[index];

                          return Card(

                            color: Colors.white,
                            elevation: 0,

                            margin: const EdgeInsets.only(bottom: 10),

                            child: ListTile(

                              leading: CircleAvatar(
                                backgroundColor: cream,
                                child: Icon(
                                  Icons.science_outlined,
                                  color: green,
                                ),
                              ),

                              title: Text(
                                name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: green,
                                ),
                              ),

                              subtitle: const Text(
                                'View ingredient information',
                              ),

                              trailing: const Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                              ),

                              onTap: () {
                                showIngredientDetails(name);
                              },
                            ),
                          );
                        },
                      ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
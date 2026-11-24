
import 'dart:io';

import 'package:material_ui/material_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';

import 'ingredient_data.dart';

class PhotoAnalysisPage extends StatefulWidget {
  const PhotoAnalysisPage({super.key});

  @override
  State<PhotoAnalysisPage> createState() =>
      _PhotoAnalysisPageState();
}

class _PhotoAnalysisPageState extends State<PhotoAnalysisPage> {
  final ImagePicker picker = ImagePicker();

  final TextRecognizer recognizer =
      TextRecognizer(script: TextRecognitionScript.latin);

  File? selectedImage;

  String extractedText = '';

  bool isLoading = false;

  List<CosmeticIngredient> matchedIngredients = [];
  List<String> unknownIngredients = [];

  // Select image from camera or gallery
  Future<void> pickImage(ImageSource source) async {
    try {
      final XFile? image = await picker.pickImage(
        source: source,
        imageQuality: 90,
      );

      if (image == null) return;

      setState(() {
        selectedImage = File(image.path);
        extractedText = '';
        matchedIngredients = [];
        unknownIngredients = [];
      });

      await analyzePhoto(image.path);
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Image error: $e')),
      );
    }
  }

  // Read text from the photograph
  Future<void> analyzePhoto(String imagePath) async {
    setState(() {
      isLoading = true;
    });

    try {
      final inputImage = InputImage.fromFilePath(imagePath);

      final RecognizedText result =
          await recognizer.processImage(inputImage);

      if (!mounted) return;

      setState(() {
        extractedText = result.text;
      });

      if (result.text.trim().isNotEmpty) {
        matchIngredients(result.text);
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Could not read the image. Try another photo.'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  // Match extracted text against our ingredient database
  void matchIngredients(String text) {
    final lines = text
        .split(RegExp(r'[,;\n]+'))
        .map((item) => item.trim())
        .where((item) => item.isNotEmpty)
        .toList();

    final List<CosmeticIngredient> matched = [];
    final List<String> unmatched = [];

    for (final line in lines) {
      final normalized = line.toLowerCase();

      CosmeticIngredient? found;

      for (final ingredient in cosmeticIngredients) {
        if (ingredient.inciName.toLowerCase() == normalized ||
            ingredient.commonNames.any(
              (name) => name.toLowerCase() == normalized,
            )) {
          found = ingredient;
          break;
        }
      }

      if (found != null) {
        if (!matched.any(
          (item) => item.inciName == found!.inciName,
        )) {
          matched.add(found);
        }
      } else {
        unmatched.add(line);
      }
    }

    setState(() {
      matchedIngredients = matched;
      unknownIngredients = unmatched;
    });
  }

  @override
  void dispose() {
    recognizer.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF967365);
    const dark = Color(0xFF49372F);

    return Scaffold(
      backgroundColor: const Color(0xFFF7EEE9),

      appBar: AppBar(
        title: const Text('Photo Ingredient Analysis'),
        backgroundColor: const Color(0xFFF7EEE9),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(18),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Scan Your Product Label',
              style: TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
                color: dark,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Take a clear photo of the ingredients list '
              'or upload an image from your gallery.',
            ),

            const SizedBox(height: 20),

            // Camera and gallery buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: isLoading
                        ? null
                        : () => pickImage(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt),
                    label: const Text('Camera'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: isLoading
                        ? null
                        : () => pickImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library),
                    label: const Text('Gallery'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: primary,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Selected photograph
            if (selectedImage != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.file(
                  selectedImage!,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.contain,
                ),
              ),

            if (isLoading) ...[
              const SizedBox(height: 20),
              const Center(
                child: CircularProgressIndicator(),
              ),
              const Center(
                child: Text('Reading ingredient label...'),
              ),
            ],

            if (extractedText.isNotEmpty) ...[
              const SizedBox(height: 25),

              const Text(
                'Extracted Text',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: dark,
                ),
              ),

              const SizedBox(height: 8),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(extractedText),
              ),

              const SizedBox(height: 25),

              const Text(
                'Recognised Ingredients',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: dark,
                ),
              ),

              const SizedBox(height: 12),

              ...matchedIngredients.map((ingredient) {
                return Card(
                  color: Colors.white,
                  child: ExpansionTile(
                    title: Text(
                      ingredient.inciName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    subtitle: Text(ingredient.category),

                    childrenPadding:
                        const EdgeInsets.all(15),

                    children: [
                      info('Description', ingredient.description),
                      info(
                        'Functions',
                        ingredient.functions.join(', '),
                      ),
                      info('Benefits', ingredient.benefits),
                      info(
                        'Possible Concerns',
                        ingredient.possibleConcerns,
                      ),
                      info(
                        'Precautions',
                        ingredient.precautions,
                      ),
                    ],
                  ),
                );
              }),

              if (matchedIngredients.isEmpty)
                const Text(
                  'No ingredients matched our current database.',
                ),

              if (unknownIngredients.isNotEmpty) ...[
                const SizedBox(height: 15),

                const Text(
                  'Unmatched Text',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(unknownIngredients.join(', ')),
              ],

              const SizedBox(height: 15),

              const Text(
                'Please verify the extracted text against the '
                'original product label. OCR may misread letters '
                'or ingredient names.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.brown,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget info(String title, String value) {
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

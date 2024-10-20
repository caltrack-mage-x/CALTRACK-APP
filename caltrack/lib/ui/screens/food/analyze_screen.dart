import 'dart:convert';
import 'dart:io';
import 'package:caltrack/domain/models/food/food_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class AnalyzeScreen extends StatefulWidget {
  final String imagePath;

  const AnalyzeScreen({super.key, required this.imagePath});

  @override
  _AnalyzeScreenState createState() => _AnalyzeScreenState();
}

class _AnalyzeScreenState extends State<AnalyzeScreen> {
  FoodModel? _foodData;
  String? _errorMessage;
  String? _foodDescription;

  @override
  void initState() {
    super.initState();
    _analyzeImage();
  }

  Future<void> _analyzeImage() async {
    try {
      Gemini.reInitialize(apiKey: 'AIzaSyD-Fj0TBzjRze1rzOT3NTwSud5spAhlldk');
      final bytes = await File(widget.imagePath).readAsBytes();

      const prompt = '''
        Analyze this image and return a JSON response with the following format:
        {
          "food_id": "string",
          "name": "string",
          "calories": integer,
          "protein": double,
          "fats": double,
          "carbohydrates": double,
          "serving_size": "string",
          "image_url": "string"
        }
        Please ensure that the data types are strictly followed: strings should be in quotes, 
        integers should not have quotes or decimals, and doubles should have decimal points. 
        Return the JSON string without any comment. Always make a guess for the food name 
        and its nutritional values if the image looks like food, even if you are unsure. 
        Only use "not recognized" if the image clearly does not contain food.
      ''';

      const descriptionPrompt = """
        Describe an interesting fun fact about the food in 2 sentences, based on the given JSON String.
        Do not repeat any information that is already included in the JSON string (such as calories, nutrients, or serving size). Focus on something fun or unique about the food that isn't already described in the JSON.
        """;

      final recognitionResult = await Gemini.instance.textAndImage(
        text: prompt,
        images: [bytes],
      );

      if (recognitionResult?.content?.parts?.last.text?.isNotEmpty ?? false) {
        String jsonString = recognitionResult?.content?.parts?.last.text ?? '';

        final descriptionResult = await Gemini.instance.textAndImage(
          text: "$descriptionPrompt $jsonString",
          images: [],
        );

        String descriptionText = descriptionResult?.content?.parts?.last.text ?? '';

        setState(() {
          _foodDescription = descriptionText;
        });
      }

      final Map<String, dynamic>? jsonResult = jsonDecode(
          recognitionResult?.content?.parts?.last.text ?? '{}');

      if (jsonResult != null && jsonResult.isNotEmpty) {
        setState(() {
          _foodData = FoodModel.fromJson(jsonResult);
        });
      } else {
        setState(() {
          _errorMessage = 'No result or invalid data format';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: _errorMessage != null
          ? Center(child: Text(_errorMessage!))
          : _foodData != null
          ? _buildFoodDataView(_foodData!)
          : _buildLoadingView(), // Use custom loading view
    );
  }

  Widget _buildLoadingView() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFD4FD), Color(0xFFFAFFD8)],
        ),
      ),
      child: const Center(
        child: SizedBox(
          width: 60,
          height: 60,
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent), // Custom color
            strokeWidth: 6, // Custom stroke width
          ),
        ),
      ),
    );
  }

  Widget _buildFoodDataView(FoodModel food) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFD4FD), Color(0xFFFAFFD8)],
        ),
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Being identified as...',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            AspectRatio(
              aspectRatio: 9 / 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(32),
                child: Image.file(
                  File(widget.imagePath),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              food.name.toUpperCase(),
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Calories: ${food.calories} kkal',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.black54,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildNutrientInfo('Protein', '${food.protein}g'),
                _buildNutrientInfo('Fats', '${food.fats}g'),
                _buildNutrientInfo('Carbs', '${food.carbohydrates}g'),
              ],
            ),
            const SizedBox(height: 16),
            if (food.servingSize != null)
              Text(
                'Serving Size: ${food.servingSize}',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black87,
                ),
              ),
            const SizedBox(height: 30),
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFFEA6175),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'About this item:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _foodDescription ?? "Loading description...",
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.justify,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Action for confirming intake
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(12),
                  backgroundColor: Colors.pinkAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
                child: const Text(
                  'Confirm intake',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrientInfo(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}

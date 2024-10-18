import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';

class GeminiScreen extends StatefulWidget {
  @override
  _GeminiScreenState createState() => _GeminiScreenState();
}

class _GeminiScreenState extends State<GeminiScreen> {
  String? _result;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    initializeGemini();
  }

  Future<void> initializeGemini() async {
    await Gemini.reInitialize(apiKey: 'AIzaSyD-Fj0TBzjRze1rzOT3NTwSud5spAhlldk');
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      try {
        final bytes = await image.readAsBytes();

        final recognitionResult = await Gemini.instance.textAndImage(
          text: 'Recognize this image',
          images: [bytes],
        );

        setState(() {
          _result = recognitionResult?.content?.parts?.last?.text ?? 'No result';
        });
      } catch (e) {
        setState(() {
          _result = 'Error: $e';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gemini Image Recognition'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            if (_result != null) ...[
              SizedBox(height: 20),
              Text('Recognition Result:'),
              Text(_result!),
            ],
          ],
        ),
      ),
    );
  }
}

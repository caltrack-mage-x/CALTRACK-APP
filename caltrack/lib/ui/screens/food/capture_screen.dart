import 'package:caltrack/ui/screens/food/preview_screen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:caltrack/ui/screens/food/analyze_screen.dart';
import 'dart:io';

class CaptureScreen extends StatefulWidget {
  const CaptureScreen({
    super.key,
    required this.firstCamera,
    required this.secondCamera,
  });

  final CameraDescription firstCamera;
  final CameraDescription secondCamera;

  @override
  CaptureScreenState createState() => CaptureScreenState();
}

class CaptureScreenState extends State<CaptureScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  bool _isUsingFirstCamera = true;

  @override
  void initState() {
    super.initState();
    _initializeCamera(widget.firstCamera);
  }

  Future<void> _initializeCamera(CameraDescription cameraDescription) async {
    _controller = CameraController(
      cameraDescription,
      ResolutionPreset.high,
    );

    _initializeControllerFuture = _controller.initialize().catchError((error) {
      _showErrorDialog(error);
    });
  }

  void _showErrorDialog(Object error) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Camera Error'),
          content: Text('Error initializing camera: $error'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takePicture() async {
    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();
      if (!context.mounted) return;

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PreviewScreen(imagePath: image.path),
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error taking picture: $e')),
      );
    }
  }

  Future<void> _pickFromGallery() async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => PreviewScreen(imagePath: pickedFile.path),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error picking image: $e')),
      );
    }
  }

  void _rotateCamera() async {
    setState(() {
      _isUsingFirstCamera = !_isUsingFirstCamera;
    });
    await _initializeCamera(_isUsingFirstCamera ? widget.firstCamera : widget.secondCamera);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // Top bar
          Container(
            color: Colors.black,
            padding: const EdgeInsets.only(top: 40, bottom: 10),
            child: const Column(
              children: [
                Text(
                  '🥕 CalTrack',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Powered by Google Gemini',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder<void>(
              future: _initializeControllerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return Center(
                    child: AspectRatio(
                      aspectRatio: 3 / 4,
                      child: CameraPreview(_controller),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildBottomIcon(Icons.cameraswitch, _rotateCamera, [Colors.pinkAccent, Colors.purpleAccent]),
                _buildBottomIcon(Icons.camera_alt, _takePicture, [Colors.redAccent, Colors.orangeAccent]),
                _buildBottomIcon(Icons.image, _pickFromGallery, [Colors.teal, Colors.cyan]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomIcon(IconData icon, Function onPressed, List<Color> gradientColors) {
    return InkWell(
      onTap: () => onPressed(),
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
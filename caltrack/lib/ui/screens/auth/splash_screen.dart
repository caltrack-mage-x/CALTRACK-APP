import 'package:flutter/material.dart';
import 'boarding1_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const BoardingScreen1()));
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen size for responsive UI
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFFF6136),
              Color(0xFFEA6175),
            ],
          ),
        ),
        child: Center(
          child: Image.asset(
            'assets/caltrack-icon.png',
            width: screenWidth * 0.4,
            height: screenWidth * 0.4,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BurnCard extends StatelessWidget {
  const BurnCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 179,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [
            Color(0xFFFF6136), // Left color
            Color(0xFFEA6175), // Right color
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color with opacity
            spreadRadius: 4, // Spread radius for the shadow
            blurRadius: 10, // Blur radius for the shadow
            offset: Offset(0, 5), // Offset for the shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            // Left side image with slight padding to move it to the right
            Padding(
              padding: const EdgeInsets.only(left: 10), // Move image slightly to the right
              child: Image.asset(
                'assets/BircycleBurn.png',
                width: 80,
                height: 80,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 20), // Space between image and text
            // Right side content
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Calories burned today',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: '605 ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: 'KKal',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18, // Smaller font size for 'KKal'
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: () {
                      print("Start session button pressed");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white, // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                    ),
                    child: const Text(
                      'Start session',
                      style: TextStyle(
                        color: Color(0xFFEA6175), // Text color
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

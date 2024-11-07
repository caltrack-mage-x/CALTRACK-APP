import 'package:flutter/material.dart';

class CaloriesCard extends StatelessWidget {
  const CaloriesCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380,
      height: 160,
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Left side text
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Your calories intake today',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    '1410 KKal',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3),
                  const Text(
                    'Sunday, May 19th 2024',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Right side image with increased size
            Image.asset(
              'assets/fireBurn.png',
              width: 100, // Increased width from 60 to 80
              height: 100, // Increased height from 60 to 80
              color: Colors.white, // Adjust if necessary
            ),
          ],
        ),
      ),
    );
  }
}

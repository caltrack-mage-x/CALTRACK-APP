import 'package:flutter/material.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 115,
      height: 153,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // Shadow position
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Stack to overlay text on the image
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: Stack(
                children: [
                  Image.asset(
                    'assets/fried_rice.png', // Replace with your actual image asset
                    width: double.infinity,
                    height: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  // Overlayed text on the image
                  Positioned(
                    bottom: 8,
                    left: 8,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Fried Rice',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 5,
                                color: Colors.black45,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '05/19/2024',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                blurRadius: 5,
                                color: Colors.black45,
                                offset: Offset(1, 1),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Bottom container with calorie count
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: const BoxDecoration(
              color: Color(0xFFFF6136),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
            ),
            child: const Text(
              '250 KKal',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

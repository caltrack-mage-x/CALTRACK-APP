import 'package:flutter/material.dart';

class DailyCard extends StatelessWidget {
  const DailyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF8FB39F), // Border color similar to green
          width: 1,
        ),
        color: Colors.white,
      ),
      child: Row(
        children: [
          // Icon Section with full height and larger icon size
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
            child: Container(
              width: 70, // Match the height of the card
              height: 70,
              color: const Color(0xFF8FB39F), // Background color of the icon
              child: Center(
                child: Image.asset(
                  'assets/DailyChallenge.png', // Replace with actual asset path
                  width: 32, // Increased icon size
                  height: 32,
                  color: Colors.white, // Color for the icon
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // Text Section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  'Daily Challenge',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4F4F4F),
                  ),
                ),
                Text(
                  'Drink 8 glasses of water',
                  style: TextStyle(
                    fontSize: 14,
                    color: Color(0xFF828282),
                  ),
                ),
              ],
            ),
          ),
          // Progress Section with adjusted alignment
          Padding(
            padding: const EdgeInsets.only(right: 19.0),
            child: const Text(
              '0/3',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4F4F4F),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

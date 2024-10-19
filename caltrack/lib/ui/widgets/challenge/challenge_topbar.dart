import 'package:flutter/material.dart';

class ChallengeTopBar extends StatelessWidget {
  final String title;
  final int currentIndex;
  final ValueChanged<int> onTabChanged;

  ChallengeTopBar({
    required this.title,
    required this.currentIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      padding: EdgeInsets.only(top: 8),
      child: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: Column(
          children: [
            SizedBox(height: 8),
            Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildTabButton(0, "Daily", Icons.wb_sunny),
                    _buildTabButton(1, "Weekly", Icons.calendar_today),
                    _buildTabButton(2, "Achievements", Icons.emoji_events),
                  ],
                ),
              ],
            ),
            SizedBox(height: 12),
          ],
        )

      ),
    );
  }

  Widget _buildTabButton(int index, String label, IconData icon) {
    bool isSelected = currentIndex == index;
    return TextButton.icon(
      onPressed: () => onTabChanged(index),
      icon: Icon(icon, color: isSelected ? Colors.orange : Colors.grey),
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.orange : Colors.grey,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

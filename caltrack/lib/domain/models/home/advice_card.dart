import 'package:flutter/material.dart';

class AdviceCard extends StatelessWidget {
  final String date;
  final String advice;
  final VoidCallback onClose;
  final String color; // New parameter to specify color condition

  const AdviceCard({
    Key? key,
    required this.date,
    required this.advice,
    required this.onClose,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: color == 'purple' 
            ? Color(0xFFFFD4FD) 
            : color == 'yellow' 
                ? Color(0xFFFAFFD8) 
                : Color(0xFFFFE3F3), // Default color if neither condition is met
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(32),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: onClose,
                child: Icon(
                  Icons.close,
                  color: Colors.grey,
                  size: 20,
                ),
              ),
              Text(
                date,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            advice,
            style: TextStyle(
              color: Colors.black87,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}

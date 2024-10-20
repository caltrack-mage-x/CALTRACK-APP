import 'package:flutter/material.dart';
import 'login_section.dart';

class Action2Page extends StatelessWidget {
  const Action2Page({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              Color(0xFFF59BB9),
              Color(0xFFFAB7DB),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/WakeUpWorkout.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      'With CalTrack, achieve a',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                      ),
                    ),
                    const Text(
                      'healthier life.',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
  onTap: () {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const LoginSection()),
    );
  },
  child: Container(
    width: 80,
    height: 80,
    decoration: const BoxDecoration(
      shape: BoxShape.circle,
      color: Color(0xFFEA6175),
    ),
    child: const Icon(
      Icons.arrow_forward,
      color: Colors.white,
      size: 30,
    ),
  ),
),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
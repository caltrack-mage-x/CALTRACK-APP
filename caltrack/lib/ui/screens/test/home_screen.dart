import 'package:flutter/material.dart';
import 'package:caltrack/domain/models/home/calories_card.dart';
import 'package:caltrack/domain/models/home/history_card.dart';
import 'package:caltrack/domain/models/home/daily_card.dart';
import 'package:caltrack/domain/models/home/weekly_card.dart';
import 'package:caltrack/domain/models/home/achievement_card.dart';
import 'package:caltrack/domain/models/home/burn_card.dart';
import 'package:caltrack/domain/models/home/advice_card.dart';
import 'package:caltrack/ui/widgets/navbar/navbar.dart';
import 'package:caltrack/ui/routes/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
              child: Container(
                width: 380,
                height: 54,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(36),
                  border: Border.all(
                    color: const Color(0xFFFE6138),
                    width: 2,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Colors.teal,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Level 12',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: 0.9,
                                backgroundColor: Colors.grey[300],
                                color: const Color(0xFFFE6138),
                                minHeight: 8,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      icon: const Icon(Icons.settings),
                      color: Colors.grey,
                      onPressed: () {
                        Navigator.pushNamed(context, AppRoutes.profile);
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Center(child: CaloriesCard()),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: const Text(
                'History',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF4F4F4F),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  HistoryCard(),
                  HistoryCard(),
                  HistoryCard(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: const Text(
                'Challenges',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF4F4F4F),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: DailyCard(),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 1.0),
              child: WeeklyCard(),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: AchievementCard(),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: const Text(
                'Burn Calories',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF4F4F4F),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: const BurnCard(),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Text(
                'Advices',
                style: TextStyle(
                  fontSize: 24,
                  color: Color(0xFF4F4F4F),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AdviceCard(
                    date: '05/19/2024',
                    advice:
                        'Remember to stretch before any exercise to avoid injury. Take at least 5-10 minutes for stretching.',
                    onClose: () {
                      print("Advice 1 closed");
                    },
                    color: 'purple',
                  ),
                  const SizedBox(width: 10),
                  AdviceCard(
                    date: '05/19/2024',
                    advice:
                        'Don\'t forget to get enough sleep—7-9 hours of rest is essential for recovery and well-being.',
                    onClose: () {
                      print("Advice 2 closed");
                    },
                    color: 'yellow',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: NavBar(), // Add NavBar as the bottomNavigationBar
    );
  }
}

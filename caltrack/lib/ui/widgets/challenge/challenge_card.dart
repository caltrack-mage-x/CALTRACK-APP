import 'package:caltrack/domain/models/gamification/achievement_model.dart';
import 'package:caltrack/domain/models/gamification/challange_model.dart';
import 'package:flutter/material.dart';

class ChallengeCard extends StatelessWidget {
  final dynamic item;

  const ChallengeCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    IconData icon;
    String title;
    String description;
    String goal;

    if (item is ChallengeModel) {
      final challenge = item as ChallengeModel;
      icon = challenge.type == 'Daily' ? Icons.wb_sunny : Icons.calendar_today;
      title = challenge.name;
      description = challenge.description ?? 'No description available';
      goal = challenge.goal ?? '0/0';

    } else if (item is AchievementModel) {
      final achievement = item as AchievementModel;
      icon = Icons.emoji_events;
      title = achievement.name;
      description = achievement.description ?? 'No description available';
      goal = '';

    } else {
      return Container();
    }

    return GestureDetector(
      onTap: () {
        print('Card tapped! $title');
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
          border: Border.all(
            color: item is ChallengeModel && item.isCompleted ? Colors.green : Colors.grey,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: item is ChallengeModel && item.isCompleted ? Colors.green[100] : Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: item is ChallengeModel && item.isCompleted ? Colors.green : Colors.grey,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            if (goal.isNotEmpty) // Display goal only if it's not empty
              Text(
                goal,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

import 'package:caltrack/domain/models/gamification/achievement_model.dart';
import 'package:caltrack/domain/models/gamification/challange_model.dart';
import 'package:caltrack/domain/services/gamification/achievement_service.dart';
import 'package:caltrack/domain/services/gamification/challange_service.dart';
import 'package:caltrack/ui/widgets/challenge/challenge_card.dart';
import 'package:caltrack/ui/widgets/challenge/challenge_timer.dart';
import 'package:caltrack/ui/widgets/challenge/challenge_topbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChallengePage extends StatefulWidget {
  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  List<ChallengeModel> allChallenges = [];
  List<AchievementModel> achievements = [];
  int _currentTabIndex = 0;
  late ChallengeService _challengeService;
  late AchievementService _achievementService;

  @override
  void initState() {
    super.initState();
    _challengeService = Provider.of<ChallengeService>(context, listen: false);
    _achievementService = Provider.of<AchievementService>(context, listen: false);
  }

  Future<void> _loadData() async {
    try {
      allChallenges = await _challengeService.getAllChallenges();
      achievements = await _achievementService.getAllAchievements();
    } catch (e) {
      print("Error loading challenges or achievements: $e");
    }
  }

  CountdownType _getCountdownType(int currentIndex) {
    switch (currentIndex) {
      case 0:
        return CountdownType.daily;
      case 1:
        return CountdownType.weekly;
      case 2:
        return CountdownType.achievement;
      default:
        return CountdownType.daily;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: ChallengeTopBar(
          title: _getTitle(),
          currentIndex: _currentTabIndex,
          onTabChanged: (index) {
            setState(() {
              _currentTabIndex = index;
            });
          },
        ),
      ),
      body: FutureBuilder<void>(
        future: _loadData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator(color: Colors.orange,));
          }

          if (snapshot.hasError) {
            return Center(child: Text("Failed to load data. Please try again later."));
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ChallengeTimer(
                  countdownType: _getCountdownType(_currentTabIndex),
                ),
                SizedBox(height: 20),
                _buildChallengesView(),
              ],
            ),
          );
        },
      ),
    );
  }

  String _getTitle() {
    switch (_currentTabIndex) {
      case 0:
        return "Daily Challenges";
      case 1:
        return "Weekly Challenges";
      case 2:
        return "Achievements";
      default:
        return "Challenges";
    }
  }

  Widget _buildChallengesView() {
    switch (_currentTabIndex) {
      case 0:
        return _buildChallengeList(allChallenges.where((challenge) => challenge.type == 'Daily').toList(), "Available Daily Challenges");
      case 1:
        return _buildChallengeList(allChallenges.where((challenge) => challenge.type == 'Weekly').toList(), "Available Weekly Challenges");
      case 2:
        return _buildAchievementList();
      default:
        return Container();
    }
  }

  Widget _buildChallengeList(List<ChallengeModel> challenges, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ...challenges.map((challenge) => ChallengeCard(item: challenge)).toList(),
        SizedBox(height: 20),
      ],
    );
  }

  Widget _buildAchievementList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Achievements", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        ...achievements.map((achievement) => ChallengeCard(item: achievement)).toList(), // Assuming ChallengeCard can handle AchievementModel
      ],
    );
  }
}

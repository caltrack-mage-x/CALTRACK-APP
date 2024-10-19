class ChallengeModel {
  final String challengeId;
  final String name;
  final String? description;
  final int xpReward;
  final String? goal;
  final String type;
  final bool isCompleted;
  final DateTime createdAt;

  ChallengeModel({
    required this.challengeId,
    required this.name,
    this.description,
    required this.xpReward,
    this.goal,
    required this.type,
    required this.isCompleted,
    required this.createdAt,
  });

  factory ChallengeModel.fromJson(Map<String, dynamic> json) {
    return ChallengeModel(
      challengeId: json['challenge_id'],
      name: json['name'],
      description: json['description'],
      xpReward: json['xp_reward'],
      goal: json['goal'],
      type: json['type'],
      isCompleted: json['is_completed'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'challenge_id': challengeId,
      'name': name,
      'description': description,
      'xp_reward': xpReward,
      'goal': goal,
      'type': type,
      'is_completed': isCompleted,
      'created_at': createdAt.toIso8601String(),
    };
  }
}

List<ChallengeModel> createDummyChallenges() {
  return [
    ChallengeModel(
      challengeId: '1',
      name: 'Hydration Challenge',
      description: 'Drink 8 glasses of water each day for a week.',
      xpReward: 150,
      goal: '0/7',
      type: 'Health',
      isCompleted: false,
      createdAt: DateTime.now().subtract(Duration(days: 1)),
    ),
    ChallengeModel(
      challengeId: '3',
      name: 'Mindful Minutes',
      description: 'Meditate for 10 minutes every day for 7 days.',
      xpReward: 250,
      goal: '3/7',
      type: 'Mindfulness',
      isCompleted: true,
      createdAt: DateTime.now().subtract(Duration(days: 3)),
    ),
    ChallengeModel(
      challengeId: '4',
      name: 'Fruits & Veggies Challenge',
      description: 'Eat at least 5 servings of fruits and vegetables daily for a week.',
      xpReward: 300,
      goal: '10/35', // total servings over 7 days
      type: 'Nutrition',
      isCompleted: false,
      createdAt: DateTime.now().subtract(Duration(days: 4)),
    ),
    ChallengeModel(
      challengeId: '5',
      name: 'Sleep Well Challenge',
      description: 'Get at least 7 hours of sleep each night for 5 nights.',
      xpReward: 180,
      goal: '4/5',
      type: 'Wellness',
      isCompleted: false,
      createdAt: DateTime.now().subtract(Duration(days: 5)),
    ),
    ChallengeModel(
      challengeId: '6',
      name: 'Reading Challenge',
      description: 'Read 3 books in a month.',
      xpReward: 350,
      goal: '1/3',
      type: 'Personal Development',
      isCompleted: true,
      createdAt: DateTime.now().subtract(Duration(days: 10)),
    ),
    ChallengeModel(
      challengeId: '7',
      name: 'Digital Detox',
      description: 'Spend a whole day without screen time once a week for a month.',
      xpReward: 400,
      goal: '0/4',
      type: 'Lifestyle',
      isCompleted: false,
      createdAt: DateTime.now().subtract(Duration(days: 12)),
    ),
  ];
}



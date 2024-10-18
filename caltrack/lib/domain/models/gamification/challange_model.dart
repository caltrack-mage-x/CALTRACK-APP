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

class AchievementModel {
  final String achievementId;
  final String name;
  final String? description;
  final int xpReward;

  AchievementModel({
    required this.achievementId,
    required this.name,
    this.description,
    required this.xpReward,
  });

  factory AchievementModel.fromJson(Map<String, dynamic> json) {
    return AchievementModel(
      achievementId: json['achievement_id'],
      name: json['name'],
      description: json['description'],
      xpReward: json['xp_reward'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'achievement_id': achievementId,
      'name': name,
      'description': description,
      'xp_reward': xpReward,
    };
  }
}

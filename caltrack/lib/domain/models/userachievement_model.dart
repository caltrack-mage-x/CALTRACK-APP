class UserAchievementModel {
  final String userAchievementId;
  final String userId;
  final String achievementId;
  final DateTime earnedAt;

  UserAchievementModel({
    required this.userAchievementId,
    required this.userId,
    required this.achievementId,
    required this.earnedAt,
  });

  factory UserAchievementModel.fromJson(Map<String, dynamic> json) {
    return UserAchievementModel(
      userAchievementId: json['user_achievement_id'],
      userId: json['user_id'],
      achievementId: json['achievement_id'],
      earnedAt: DateTime.parse(json['earned_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_achievement_id': userAchievementId,
      'user_id': userId,
      'achievement_id': achievementId,
      'earned_at': earnedAt.toIso8601String(),
    };
  }
}

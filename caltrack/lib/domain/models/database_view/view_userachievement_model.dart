class UserAchievementsModel {
  final String userAchievementId;
  final String userName;
  final String? profilePicture;
  final String achievementName;
  final DateTime earnedAt;

  UserAchievementsModel({
    required this.userAchievementId,
    required this.userName,
    this.profilePicture,
    required this.achievementName,
    required this.earnedAt,
  });

  factory UserAchievementsModel.fromJson(Map<String, dynamic> json) {
    return UserAchievementsModel(
      userAchievementId: json['user_achievement_id'],
      userName: json['user_name'],
      profilePicture: json['profile_picture'],
      achievementName: json['achievement_name'],
      earnedAt: DateTime.parse(json['earned_at']),
    );
  }
}

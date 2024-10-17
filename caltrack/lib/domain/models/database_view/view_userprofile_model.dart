class UserProfileModel {
  final String userId;
  final String username;
  final String email;
  final int? age;
  final double? height;
  final double? weight;
  final String? gender;
  final String? activityLevel;
  final int? goalCalories;
  final int? totalXp;
  final int? level;
  final DateTime createdAt;
  final String? profilePicture;
  final String? banner;

  UserProfileModel({
    required this.userId,
    required this.username,
    required this.email,
    this.age,
    this.height,
    this.weight,
    this.gender,
    this.activityLevel,
    this.goalCalories,
    this.totalXp,
    this.level,
    required this.createdAt,
    this.profilePicture,
    this.banner,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      userId: json['user_id'],
      username: json['username'],
      email: json['email'],
      age: json['age'],
      height: json['height'],
      weight: json['weight'],
      gender: json['gender'],
      activityLevel: json['activity_level'],
      goalCalories: json['goal_calories'],
      totalXp: json['total_xp'],
      level: json['level'],
      createdAt: DateTime.parse(json['created_at']),
      profilePicture: json['profile_picture'],
      banner: json['banner'],
    );
  }
}

class UserModel {
  final String userId;
  final String username;
  final String email;
  final String password;
  final int? age;
  final double? height;
  final double? weight;
  final String? gender;
  final String? activityLevel;
  final int? goalCalories;
  final int totalXp;
  final int level;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  UserModel({
    required this.userId,
    required this.username,
    required this.email,
    required this.password,
    this.age,
    this.height,
    this.weight,
    this.gender,
    this.activityLevel,
    this.goalCalories,
    this.totalXp = 0,
    this.level = 1,
    this.createdAt,
    this.updatedAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      age: json['age'],
      height: json['height'],
      weight: json['weight'],
      gender: json['gender'],
      activityLevel: json['activity_level'],
      goalCalories: json['goal_calories'],
      totalXp: json['total_xp'],
      level: json['level'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': username,
      'email': email,
      'password': password,
      'age': age,
      'height': height,
      'weight': weight,
      'gender': gender,
      'activity_level': activityLevel,
      'goal_calories': goalCalories,
      'total_xp': totalXp,
      'level': level,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}

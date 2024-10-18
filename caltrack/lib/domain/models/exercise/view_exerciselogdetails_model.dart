class ExerciseLogDetailsModel {
  final String logId;
  final String userName;
  final String exerciseName;
  final double durationMinutes;
  final int totalCaloriesBurned;
  final DateTime performedAt;

  ExerciseLogDetailsModel({
    required this.logId,
    required this.userName,
    required this.exerciseName,
    required this.durationMinutes,
    required this.totalCaloriesBurned,
    required this.performedAt,
  });

  factory ExerciseLogDetailsModel.fromJson(Map<String, dynamic> json) {
    return ExerciseLogDetailsModel(
      logId: json['log_id'],
      userName: json['user_name'],
      exerciseName: json['exercise_name'],
      durationMinutes: json['duration_minutes'],
      totalCaloriesBurned: json['total_calories_burned'],
      performedAt: DateTime.parse(json['performed_at']),
    );
  }
}

class ExerciseLogModel {
  final String logId;
  final String userId;
  final String exerciseId;
  final double durationMinutes;
  final int totalCaloriesBurned;
  final DateTime performedAt;

  ExerciseLogModel({
    required this.logId,
    required this.userId,
    required this.exerciseId,
    required this.durationMinutes,
    required this.totalCaloriesBurned,
    required this.performedAt,
  });

  factory ExerciseLogModel.fromJson(Map<String, dynamic> json) {
    return ExerciseLogModel(
      logId: json['log_id'],
      userId: json['user_id'],
      exerciseId: json['exercise_id'],
      durationMinutes: json['duration_minutes'],
      totalCaloriesBurned: json['total_calories_burned'],
      performedAt: DateTime.parse(json['performed_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'log_id': logId,
      'user_id': userId,
      'exercise_id': exerciseId,
      'duration_minutes': durationMinutes,
      'total_calories_burned': totalCaloriesBurned,
      'performed_at': performedAt.toIso8601String(),
    };
  }
}

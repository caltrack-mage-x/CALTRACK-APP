class UserChallengeModel {
  final String userChallengeId;
  final String userId;
  final String challengeId;
  final String? status;
  final double progress;
  final DateTime? completedAt;

  UserChallengeModel({
    required this.userChallengeId,
    required this.userId,
    required this.challengeId,
    this.status,
    this.progress = 0.0,
    this.completedAt,
  });

  factory UserChallengeModel.fromJson(Map<String, dynamic> json) {
    return UserChallengeModel(
      userChallengeId: json['user_challenge_id'],
      userId: json['user_id'],
      challengeId: json['challenge_id'],
      status: json['status'],
      progress: json['progress'],
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_challenge_id': userChallengeId,
      'user_id': userId,
      'challenge_id': challengeId,
      'status': status,
      'progress': progress,
      'completed_at': completedAt?.toIso8601String(),
    };
  }
}

class UserChallengesModel {
  final String userChallengeId;
  final String userName;
  final String? profilePicture;
  final String challengeName;
  final String status;
  final double progress;
  final DateTime? completedAt;

  UserChallengesModel({
    required this.userChallengeId,
    required this.userName,
    this.profilePicture,
    required this.challengeName,
    required this.status,
    required this.progress,
    this.completedAt,
  });

  factory UserChallengesModel.fromJson(Map<String, dynamic> json) {
    return UserChallengesModel(
      userChallengeId: json['user_challenge_id'],
      userName: json['user_name'],
      profilePicture: json['profile_picture'],
      challengeName: json['challenge_name'],
      status: json['status'],
      progress: json['progress'],
      completedAt: json['completed_at'] != null
          ? DateTime.parse(json['completed_at'])
          : null,
    );
  }
}

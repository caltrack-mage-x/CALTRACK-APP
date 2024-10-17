class LeaderboardModel {
  final String leaderboardId;
  final String userId;
  final int rank;
  final int xpPoints;
  final DateTime date;

  LeaderboardModel({
    required this.leaderboardId,
    required this.userId,
    required this.rank,
    required this.xpPoints,
    required this.date,
  });

  factory LeaderboardModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardModel(
      leaderboardId: json['leaderboard_id'],
      userId: json['user_id'],
      rank: json['rank'],
      xpPoints: json['xp_points'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'leaderboard_id': leaderboardId,
      'user_id': userId,
      'rank': rank,
      'xp_points': xpPoints,
      'date': date.toIso8601String(),
    };
  }
}

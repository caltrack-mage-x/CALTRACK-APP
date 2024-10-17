class LeaderboardViewModel {
  final String leaderboardId;
  final String userName;
  final String? profilePicture;
  final int rank;
  final int xpPoints;
  final DateTime date;

  LeaderboardViewModel({
    required this.leaderboardId,
    required this.userName,
    this.profilePicture,
    required this.rank,
    required this.xpPoints,
    required this.date,
  });

  factory LeaderboardViewModel.fromJson(Map<String, dynamic> json) {
    return LeaderboardViewModel(
      leaderboardId: json['leaderboard_id'],
      userName: json['user_name'],
      profilePicture: json['profile_picture'],
      rank: json['rank'],
      xpPoints: json['xp_points'],
      date: DateTime.parse(json['date']),
    );
  }
}

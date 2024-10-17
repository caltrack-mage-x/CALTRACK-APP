import '../repository/leaderboard_repository.dart';
import '../models/leaderboard_model.dart';

class LeaderboardService {
  final LeaderboardRepository _leaderboardRepository;

  LeaderboardService(this._leaderboardRepository);

  Future<List<LeaderboardModel>> getAllLeaderboards() async {
    return await _leaderboardRepository.getAllLeaderboards();
  }

  Future<void> createLeaderboard(LeaderboardModel leaderboard) async {
    await _leaderboardRepository.createLeaderboard(leaderboard);
  }

  Future<void> updateLeaderboard(LeaderboardModel leaderboard) async {
    await _leaderboardRepository.updateLeaderboard(leaderboard);
  }

  Future<void> deleteLeaderboard(String leaderboardId) async {
    await _leaderboardRepository.deleteLeaderboard(leaderboardId);
  }
}

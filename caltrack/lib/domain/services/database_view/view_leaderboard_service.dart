import 'package:caltrack/domain/models/database_view/view_leaderboard.dart';
import 'package:caltrack/domain/repository/database_view/view_leaderboard_repository.dart';

class LeaderboardViewService {
  final LeaderboardViewRepository _leaderboardViewRepository;

  LeaderboardViewService(this._leaderboardViewRepository);

  Future<List<LeaderboardViewModel>> fetchAllLeaderboardEntries() async {
    try {
      return await _leaderboardViewRepository.getAllLeaderboardEntries();
    } catch (e) {
      throw Exception('Failed to load leaderboard entries: $e');
    }
  }
}

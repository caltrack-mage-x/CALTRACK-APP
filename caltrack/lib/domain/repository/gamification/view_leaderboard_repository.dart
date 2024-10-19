import 'package:caltrack/domain/models/gamification/view_leaderboard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LeaderboardViewRepository {
  final SupabaseClient _client;

  LeaderboardViewRepository(this._client);

  Future<List<LeaderboardViewModel>> getAllLeaderboardEntries() async {
    final response = await _client.from('leaderboard_view').select();

    if (response == null || (response as List).isEmpty) {
      throw Exception('No leaderboard entries found.');
    }

    return (response as List)
        .map((leaderboard) => LeaderboardViewModel.fromJson(leaderboard))
        .toList();
  }
}

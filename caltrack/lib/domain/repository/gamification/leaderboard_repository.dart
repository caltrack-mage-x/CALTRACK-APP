import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/gamification/leaderboard_model.dart';

class LeaderboardRepository {
  final SupabaseClient _client;

  LeaderboardRepository(this._client);

  Future<List<LeaderboardModel>> getAllLeaderboards() async {
    final response = await _client.from('Leaderboard').select().maybeSingle();

    if (response == null || (response as List).isEmpty) {
      throw Exception('No leaderboards found.');
    }

    return (response as List)
        .map((leaderboard) => LeaderboardModel.fromJson(leaderboard))
        .toList();
  }

  Future<void> createLeaderboard(LeaderboardModel leaderboard) async {
    final response = await _client
        .from('Leaderboard')
        .insert(leaderboard.toJson())
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to create leaderboard.');
    }
  }

  Future<void> updateLeaderboard(LeaderboardModel leaderboard) async {
    final response = await _client
        .from('Leaderboard')
        .update(leaderboard.toJson())
        .eq('leaderboard_id', leaderboard.leaderboardId)
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to update leaderboard.');
    }
  }

  Future<void> deleteLeaderboard(String leaderboardId) async {
    final response = await _client
        .from('Leaderboard')
        .delete()
        .eq('leaderboard_id', leaderboardId)
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to delete leaderboard.');
    }
  }
}

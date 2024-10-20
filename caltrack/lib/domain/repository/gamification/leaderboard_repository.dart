// Fixed
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/gamification/leaderboard_model.dart';
import 'package:flutter/cupertino.dart';

class LeaderboardRepository {
  final SupabaseClient _client;

  LeaderboardRepository(this._client);

  Future<List<LeaderboardModel>> getAllLeaderboards() async {
    final response = await _client.from('Leaderboard').select();

    debugPrint('getAllLeaderboards Response: $response');

    if ((response).isEmpty) {
      debugPrint('No leaderboards found.');
      throw Exception('No leaderboards found.');
    }

    return (response)
        .map((leaderboard) => LeaderboardModel.fromJson(leaderboard))
        .toList();
  }

  Future<void> createLeaderboard(LeaderboardModel leaderboard) async {
    final response = await _client
        .from('Leaderboard')
        .insert(leaderboard.toJson())
        .single();

    debugPrint('createLeaderboard Response: $response');
  }

  Future<void> updateLeaderboard(LeaderboardModel leaderboard) async {
    final response = await _client
        .from('Leaderboard')
        .update(leaderboard.toJson())
        .eq('leaderboard_id', leaderboard.leaderboardId)
        .single();

    debugPrint('updateLeaderboard Response: $response');
  }

  Future<void> deleteLeaderboard(String leaderboardId) async {
    final response = await _client
        .from('Leaderboard')
        .delete()
        .eq('leaderboard_id', leaderboardId)
        .single();

    debugPrint('deleteLeaderboard Response: $response');
  }
}

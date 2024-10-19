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

    if (response == null || (response as List).isEmpty) {
      debugPrint('No leaderboards found.');
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
        .single();

    debugPrint('createLeaderboard Response: $response');

    if (response == null) {
      debugPrint('Failed to create leaderboard.');
      throw Exception('Failed to create leaderboard.');
    }
  }

  Future<void> updateLeaderboard(LeaderboardModel leaderboard) async {
    final response = await _client
        .from('Leaderboard')
        .update(leaderboard.toJson())
        .eq('leaderboard_id', leaderboard.leaderboardId)
        .single();

    debugPrint('updateLeaderboard Response: $response');

    if (response == null) {
      debugPrint('Failed to update leaderboard.');
      throw Exception('Failed to update leaderboard.');
    }
  }

  Future<void> deleteLeaderboard(String leaderboardId) async {
    final response = await _client
        .from('Leaderboard')
        .delete()
        .eq('leaderboard_id', leaderboardId)
        .single();

    debugPrint('deleteLeaderboard Response: $response');

    if (response == null) {
      debugPrint('Failed to delete leaderboard.');
      throw Exception('Failed to delete leaderboard.');
    }
  }
}

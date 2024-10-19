// Fixed
import 'package:caltrack/domain/models/gamification/view_leaderboard.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/cupertino.dart';

class LeaderboardViewRepository {
  final SupabaseClient _client;

  LeaderboardViewRepository(this._client);

  Future<List<LeaderboardViewModel>> getAllLeaderboardEntries() async {
    final response = await _client.from('leaderboard_view').select();

    debugPrint('getAllLeaderboardEntries Response: $response');

    if (response == null || (response as List).isEmpty) {
      debugPrint('No leaderboard entries found.');
      throw Exception('No leaderboard entries found.');
    }

    return (response as List)
        .map((leaderboard) => LeaderboardViewModel.fromJson(leaderboard))
        .toList();
  }
}

import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/gamification/achievement_model.dart';

class AchievementRepository {
  final SupabaseClient _client;

  AchievementRepository(this._client);

  Future<List<AchievementModel>> getAllAchievements() async {
    final response = await _client.from('Achievement').select();

    debugPrint('getAllAchievements Response: $response');

    if ((response).isEmpty) {
      debugPrint('No achievements found.');
      throw Exception('No achievements found.');
    }

    return (response)
        .map((achievement) => AchievementModel.fromJson(achievement))
        .toList();
  }

  Future<void> createAchievement(AchievementModel achievement) async {
    final response = await _client
        .from('Achievement')
        .insert(achievement.toJson())
        .single();

    debugPrint('createAchievement Response: $response');
  }

  Future<void> updateAchievement(AchievementModel achievement) async {
    final response = await _client
        .from('Achievement')
        .update(achievement.toJson())
        .eq('achievement_id', achievement.achievementId)
        .single();

    debugPrint('updateAchievement Response: $response');
  }

  Future<void> deleteAchievement(String achievementId) async {
    final response = await _client
        .from('Achievement')
        .delete()
        .eq('achievement_id', achievementId)
        .single();

    debugPrint('deleteAchievement Response: $response');
  }
}

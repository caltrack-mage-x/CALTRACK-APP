import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/gamification/achievement_model.dart';

class AchievementRepository {
  final SupabaseClient _client;

  AchievementRepository(this._client);

  Future<List<AchievementModel>> getAllAchievements() async {
    final response = await _client.from('Achievement').select().maybeSingle();

    if (response == null || (response as List).isEmpty) {
      throw Exception('No achievements found.');
    }

    return (response as List)
        .map((achievement) => AchievementModel.fromJson(achievement))
        .toList();
  }

  Future<void> createAchievement(AchievementModel achievement) async {
    final response = await _client
        .from('Achievement')
        .insert(achievement.toJson())
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to create achievement.');
    }
  }

  Future<void> updateAchievement(AchievementModel achievement) async {
    final response = await _client
        .from('Achievement')
        .update(achievement.toJson())
        .eq('achievement_id', achievement.achievementId)
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to update achievement.');
    }
  }

  Future<void> deleteAchievement(String achievementId) async {
    final response = await _client
        .from('Achievement')
        .delete()
        .eq('achievement_id', achievementId)
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to delete achievement.');
    }
  }
}

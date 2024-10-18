import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/gamification/userachievement_model.dart';

class UserAchievementRepository {
  final SupabaseClient _client;

  UserAchievementRepository(this._client);

  Future<List<UserAchievementModel>> getAllUserAchievements() async {
    final response =
        await _client.from('UserAchievement').select().maybeSingle();

    if (response == null || (response as List).isEmpty) {
      throw Exception('No user achievements found.');
    }

    return (response as List)
        .map(
            (userAchievement) => UserAchievementModel.fromJson(userAchievement))
        .toList();
  }

  Future<void> createUserAchievement(
      UserAchievementModel userAchievement) async {
    final response = await _client
        .from('UserAchievement')
        .insert(userAchievement.toJson())
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to create user achievement.');
    }
  }

  Future<void> updateUserAchievement(
      UserAchievementModel userAchievement) async {
    final response = await _client
        .from('UserAchievement')
        .update(userAchievement.toJson())
        .eq('user_achievement_id', userAchievement.userAchievementId)
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to update user achievement.');
    }
  }

  Future<void> deleteUserAchievement(String userAchievementId) async {
    final response = await _client
        .from('UserAchievement')
        .delete()
        .eq('user_achievement_id', userAchievementId)
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to delete user achievement.');
    }
  }
}

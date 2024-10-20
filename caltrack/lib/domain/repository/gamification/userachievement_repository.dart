// Fixed
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/gamification/userachievement_model.dart';
import 'package:flutter/cupertino.dart';

class UserAchievementRepository {
  final SupabaseClient _client;

  UserAchievementRepository(this._client);

  Future<List<UserAchievementModel>> getAllUserAchievements() async {
    final response = await _client.from('UserAchievement').select();

    debugPrint('getAllUserAchievements Response: $response');

    if ((response).isEmpty) {
      debugPrint('No user achievements found.');
      throw Exception('No user achievements found.');
    }

    return (response)
        .map((userAchievement) => UserAchievementModel.fromJson(userAchievement))
        .toList();
  }

  Future<void> createUserAchievement(UserAchievementModel userAchievement) async {
    final response = await _client
        .from('UserAchievement')
        .insert(userAchievement.toJson())
        .single();

    debugPrint('createUserAchievement Response: $response');
  }

  Future<void> updateUserAchievement(UserAchievementModel userAchievement) async {
    final response = await _client
        .from('UserAchievement')
        .update(userAchievement.toJson())
        .eq('user_achievement_id', userAchievement.userAchievementId)
        .single();

    debugPrint('updateUserAchievement Response: $response');
  }

  Future<void> deleteUserAchievement(String userAchievementId) async {
    final response = await _client
        .from('UserAchievement')
        .delete()
        .eq('user_achievement_id', userAchievementId)
        .single();

    debugPrint('deleteUserAchievement Response: $response');
  }
}

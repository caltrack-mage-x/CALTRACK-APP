import 'package:caltrack/domain/models/gamification/view_userachievement_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserAchievementsRepository {
  final SupabaseClient _client;

  UserAchievementsRepository(this._client);

  Future<List<UserAchievementsModel>> getAllUserAchievements() async {
    final response = await _client.from('user_achievements').select();

    if (response == null || (response as List).isEmpty) {
      throw Exception('No user achievements found.');
    }

    return (response as List)
        .map((userAchievement) =>
            UserAchievementsModel.fromJson(userAchievement))
        .toList();
  }
}

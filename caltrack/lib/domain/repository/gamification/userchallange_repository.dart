import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/gamification/userchallange_model.dart';

class UserChallengeRepository {
  final SupabaseClient _client;

  UserChallengeRepository(this._client);

  Future<List<UserChallengeModel>> getAllUserChallenges() async {
    final response = await _client.from('UserChallenge').select().maybeSingle();

    if (response == null || (response as List).isEmpty) {
      throw Exception('No user challenges found.');
    }

    return (response as List)
        .map((userChallenge) => UserChallengeModel.fromJson(userChallenge))
        .toList();
  }

  Future<void> createUserChallenge(UserChallengeModel userChallenge) async {
    final response = await _client
        .from('UserChallenge')
        .insert(userChallenge.toJson())
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to create user challenge.');
    }
  }

  Future<void> updateUserChallenge(UserChallengeModel userChallenge) async {
    final response = await _client
        .from('UserChallenge')
        .update(userChallenge.toJson())
        .eq('user_challenge_id', userChallenge.userChallengeId)
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to update user challenge.');
    }
  }

  Future<void> deleteUserChallenge(String userChallengeId) async {
    final response = await _client
        .from('UserChallenge')
        .delete()
        .eq('user_challenge_id', userChallengeId)
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to delete user challenge.');
    }
  }
}

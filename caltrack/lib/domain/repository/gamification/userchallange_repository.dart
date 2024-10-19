// Fixed
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/gamification/userchallange_model.dart';
import 'package:flutter/cupertino.dart';

class UserChallengeRepository {
  final SupabaseClient _client;

  UserChallengeRepository(this._client);

  Future<List<UserChallengeModel>> getAllUserChallenges() async {
    final response = await _client.from('UserChallenge').select();

    debugPrint('getAllUserChallenges Response: $response');

    if (response == null || (response as List).isEmpty) {
      debugPrint('No user challenges found.');
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
        .single();

    debugPrint('createUserChallenge Response: $response');

    if (response == null) {
      debugPrint('Failed to create user challenge.');
      throw Exception('Failed to create user challenge.');
    }
  }

  Future<void> updateUserChallenge(UserChallengeModel userChallenge) async {
    final response = await _client
        .from('UserChallenge')
        .update(userChallenge.toJson())
        .eq('user_challenge_id', userChallenge.userChallengeId)
        .single();

    debugPrint('updateUserChallenge Response: $response');

    if (response == null) {
      debugPrint('Failed to update user challenge.');
      throw Exception('Failed to update user challenge.');
    }
  }

  Future<void> deleteUserChallenge(String userChallengeId) async {
    final response = await _client
        .from('UserChallenge')
        .delete()
        .eq('user_challenge_id', userChallengeId)
        .single();

    debugPrint('deleteUserChallenge Response: $response');

    if (response == null) {
      debugPrint('Failed to delete user challenge.');
      throw Exception('Failed to delete user challenge.');
    }
  }
}

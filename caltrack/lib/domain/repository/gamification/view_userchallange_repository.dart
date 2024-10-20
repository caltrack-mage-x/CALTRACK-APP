// Fixed
import 'package:caltrack/domain/models/gamification/view_userchallange_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/cupertino.dart';

class UserChallengesRepository {
  final SupabaseClient _client;

  UserChallengesRepository(this._client);

  Future<List<UserChallengesModel>> getAllUserChallenges() async {
    final response = await _client.from('user_challenges').select();

    debugPrint('getAllUserChallenges Response: $response');

    if ((response).isEmpty) {
      debugPrint('No user challenges found.');
      throw Exception('No user challenges found.');
    }

    return (response)
        .map((userChallenge) => UserChallengesModel.fromJson(userChallenge))
        .toList();
  }
}

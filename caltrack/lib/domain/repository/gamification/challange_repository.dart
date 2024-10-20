import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/gamification/challange_model.dart';

class ChallengeRepository {
  final SupabaseClient _client;

  ChallengeRepository(this._client);

  Future<List<ChallengeModel>> getAllChallenges() async {
    final response = await _client.from('Challenge').select();

    debugPrint('getAllChallenges Response: $response');

    if ((response).isEmpty) {
      debugPrint('No challenges found.');
      throw Exception('No challenges found.');
    }

    return (response)
        .map((challenge) => ChallengeModel.fromJson(challenge))
        .toList();
  }

  Future<void> createChallenge(ChallengeModel challenge) async {
    final response = await _client
        .from('Challenge')
        .insert(challenge.toJson())
        .single();

    debugPrint('createChallenge Response: $response');
  }

  Future<void> updateChallenge(ChallengeModel challenge) async {
    final response = await _client
        .from('Challenge')
        .update(challenge.toJson())
        .eq('challenge_id', challenge.challengeId)
        .single();

    debugPrint('updateChallenge Response: $response');
  }

  Future<void> deleteChallenge(String challengeId) async {
    final response = await _client
        .from('Challenge')
        .delete()
        .eq('challenge_id', challengeId)
        .single();

    debugPrint('deleteChallenge Response: $response');
  }
}

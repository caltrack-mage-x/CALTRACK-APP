import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/challange_model.dart';

class ChallengeRepository {
  final SupabaseClient _client;

  ChallengeRepository(this._client);

  Future<List<ChallengeModel>> getAllChallenges() async {
    final response = await _client.from('Challenge').select().maybeSingle();

    if (response == null || (response as List).isEmpty) {
      throw Exception('No challenges found.');
    }

    return (response as List)
        .map((challenge) => ChallengeModel.fromJson(challenge))
        .toList();
  }

  Future<void> createChallenge(ChallengeModel challenge) async {
    final response = await _client
        .from('Challenge')
        .insert(challenge.toJson())
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to create challenge.');
    }
  }

  Future<void> updateChallenge(ChallengeModel challenge) async {
    final response = await _client
        .from('Challenge')
        .update(challenge.toJson())
        .eq('challenge_id', challenge.challengeId)
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to update challenge.');
    }
  }

  Future<void> deleteChallenge(String challengeId) async {
    final response = await _client
        .from('Challenge')
        .delete()
        .eq('challenge_id', challengeId)
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to delete challenge.');
    }
  }
}

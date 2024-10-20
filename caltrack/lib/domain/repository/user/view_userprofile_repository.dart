// Fixed
import 'package:caltrack/domain/models/user/view_userprofile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';

class UserProfileRepository {
  final SupabaseClient _client;

  UserProfileRepository(this._client);

  Future<List<UserProfileModel>> getAllUserProfiles() async {
    final response = await _client.from('user_profile').select();

    debugPrint('getAllUserProfiles Response: $response');

    if ((response).isEmpty) {
      debugPrint('No user profiles found.');
      throw Exception('No user profiles found.');
    }

    return (response)
        .map((userProfile) => UserProfileModel.fromJson(userProfile))
        .toList();
  }

  Future<UserProfileModel?> getUserProfile(String userId) async {
    final response = await _client
        .from('user_profile')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    debugPrint('getUserProfile Response for userId $userId: $response');

    if (response == null) {
      debugPrint('User profile not found for userId $userId.');
      return null;
    }

    return UserProfileModel.fromJson(response);
  }
}
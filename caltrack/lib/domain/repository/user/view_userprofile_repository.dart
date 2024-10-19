import 'package:caltrack/domain/models/user/view_userprofile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserProfileRepository {
  final SupabaseClient _client;

  UserProfileRepository(this._client);

  Future<List<UserProfileModel>> getAllUserProfiles() async {
    final response = await _client.from('user_profile').select();

    if (response == null || (response as List).isEmpty) {
      throw Exception('No user profiles found.');
    }

    return (response as List)
        .map((userProfile) => UserProfileModel.fromJson(userProfile))
        .toList();
  }

  Future<UserProfileModel?> getUserProfile(String userId) async {
    final response = await _client
        .from('user_profile')
        .select()
        .eq('user_id', userId)
        .maybeSingle();

    if (response == null) {
      return null;
    }

    return UserProfileModel.fromJson(response);
  }
}

import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/user/user_model.dart';

class UserRepository {
  final SupabaseClient _client;

  UserRepository(this._client);

  Future<List<UserModel>> getAllUsers() async {
    final response = await _client.from('User').select().maybeSingle();

    if (response == null || (response as List).isEmpty) {
      throw Exception('No users found.');
    }

    return (response as List).map((user) => UserModel.fromJson(user)).toList();
  }

  Future<void> createUser(UserModel user) async {
    final response =
        await _client.from('User').insert(user.toJson()).maybeSingle();

    if (response == null) {
      throw Exception('Failed to create user.');
    }
  }

  Future<void> updateUser(UserModel user) async {
    final response = await _client
        .from('User')
        .update(user.toJson())
        .eq('user_id', user.userId)
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to update user.');
    }
  }

  Future<void> deleteUser(String userId) async {
    final response =
        await _client.from('User').delete().eq('user_id', userId).maybeSingle();

    if (response == null) {
      throw Exception('Failed to delete user.');
    }
  }
}

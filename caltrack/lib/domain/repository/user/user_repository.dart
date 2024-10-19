// Fixed
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/user/user_model.dart';
import 'package:flutter/cupertino.dart';

class UserRepository {
  final SupabaseClient _client;

  UserRepository(this._client);

  Future<List<UserModel>> getAllUsers() async {
    final response = await _client.from('User').select();

    debugPrint('getAllUsers Response: $response');

    if (response == null || (response as List).isEmpty) {
      debugPrint('No users found.');
      throw Exception('No users found.');
    }

    return (response as List).map((user) => UserModel.fromJson(user)).toList();
  }

  Future<void> createUser(UserModel user) async {
    final response = await _client.from('User').insert(user.toJson());

    debugPrint('createUser Response: $response');

    if (response == null) {
      debugPrint('Failed to create user.');
      throw Exception('Failed to create user.');
    }
  }

  Future<void> updateUser(UserModel user) async {
    final response = await _client
        .from('User')
        .update(user.toJson())
        .eq('user_id', user.userId);

    debugPrint('updateUser Response: $response');

    if (response == null) {
      debugPrint('Failed to update user.');
      throw Exception('Failed to update user.');
    }
  }

  Future<void> deleteUser(String userId) async {
    final response = await _client
        .from('User')
        .delete()
        .eq('user_id', userId);

    debugPrint('deleteUser Response: $response');

    if (response == null) {
      debugPrint('Failed to delete user.');
      throw Exception('Failed to delete user.');
    }
  }
}

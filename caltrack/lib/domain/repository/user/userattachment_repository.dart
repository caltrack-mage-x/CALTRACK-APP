// Fixed
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/user/userattachment_model.dart';
import 'package:flutter/cupertino.dart';

class UserAttachmentRepository {
  final SupabaseClient _client;

  UserAttachmentRepository(this._client);

  Future<List<UserAttachmentModel>> getAllUserAttachments() async {
    final response = await _client.from('UserAttachment').select();

    debugPrint('getAllUserAttachments Response: $response');

    if ((response).isEmpty) {
      debugPrint('No user attachments found.');
      throw Exception('No user attachments found.');
    }

    return (response)
        .map((attachment) => UserAttachmentModel.fromJson(attachment))
        .toList();
  }

  Future<void> createUserAttachment(UserAttachmentModel attachment) async {
    final response = await _client
        .from('UserAttachment')
        .insert(attachment.toJson());

    debugPrint('createUserAttachment Response: $response');

    if (response == null) {
      debugPrint('Failed to create user attachment.');
      throw Exception('Failed to create user attachment.');
    }
  }

  Future<void> updateUserAttachment(UserAttachmentModel attachment) async {
    final response = await _client
        .from('UserAttachment')
        .update(attachment.toJson())
        .eq('attachment_id', attachment.attachmentId);

    debugPrint('updateUserAttachment Response: $response');

    if (response == null) {
      debugPrint('Failed to update user attachment.');
      throw Exception('Failed to update user attachment.');
    }
  }

  Future<void> deleteUserAttachment(String attachmentId) async {
    final response = await _client
        .from('UserAttachment')
        .delete()
        .eq('attachment_id', attachmentId);

    debugPrint('deleteUserAttachment Response: $response');

    if (response == null) {
      debugPrint('Failed to delete user attachment.');
      throw Exception('Failed to delete user attachment.');
    }
  }
}

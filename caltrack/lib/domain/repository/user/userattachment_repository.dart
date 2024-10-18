import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/user/userattachment_model.dart';

class UserAttachmentRepository {
  final SupabaseClient _client;

  UserAttachmentRepository(this._client);

  Future<List<UserAttachmentModel>> getAllUserAttachments() async {
    final response =
        await _client.from('UserAttachment').select().maybeSingle();

    if (response == null || (response as List).isEmpty) {
      throw Exception('No user attachments found.');
    }

    return (response as List)
        .map((attachment) => UserAttachmentModel.fromJson(attachment))
        .toList();
  }

  Future<void> createUserAttachment(UserAttachmentModel attachment) async {
    final response = await _client
        .from('UserAttachment')
        .insert(attachment.toJson())
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to create user attachment.');
    }
  }

  Future<void> updateUserAttachment(UserAttachmentModel attachment) async {
    final response = await _client
        .from('UserAttachment')
        .update(attachment.toJson())
        .eq('attachment_id', attachment.attachmentId)
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to update user attachment.');
    }
  }

  Future<void> deleteUserAttachment(String attachmentId) async {
    final response = await _client
        .from('UserAttachment')
        .delete()
        .eq('attachment_id', attachmentId)
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to delete user attachment.');
    }
  }
}

// Fixed
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/conversation/message_model.dart';

class MessageRepository {
  final SupabaseClient _client;

  MessageRepository(this._client);

  Future<List<ConversationModel>> getAllMessages() async {
    final response = await _client.from('Message').select();

    debugPrint('getAllMessages Response: $response');

    if (response == null || (response as List).isEmpty) {
      debugPrint('No messages found.');
      throw Exception('No messages found.');
    }

    return (response as List)
        .map((message) => ConversationModel.fromJson(message))
        .toList();
  }

  Future<void> createMessage(ConversationModel message) async {
    final response =
    await _client.from('Message').insert(message.toJson()).single();

    debugPrint('createMessage Response: $response');

    if (response == null) {
      debugPrint('Failed to create message.');
      throw Exception('Failed to create message.');
    }
  }

  Future<void> updateMessage(ConversationModel message) async {
    final response = await _client
        .from('Message')
        .update(message.toJson())
        .eq('message_id', message.conversationId)
        .single();

    debugPrint('updateMessage Response: $response');

    if (response == null) {
      debugPrint('Failed to update message.');
      throw Exception('Failed to update message.');
    }
  }

  Future<void> deleteMessage(String messageId) async {
    final response = await _client
        .from('Message')
        .delete()
        .eq('message_id', messageId)
        .single();

    debugPrint('deleteMessage Response: $response');

    if (response == null) {
      debugPrint('Failed to delete message.');
      throw Exception('Failed to delete message.');
    }
  }
}

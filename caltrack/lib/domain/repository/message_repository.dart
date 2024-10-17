import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/message_model.dart';

class ConversationRepository {
  final SupabaseClient _client;

  ConversationRepository(this._client);

  Future<List<ConversationModel>> getAllMessages() async {
    final response = await _client.from('Message').select().maybeSingle();

    if (response == null || (response as List).isEmpty) {
      throw Exception('No messages found.');
    }

    return (response as List)
        .map((message) => ConversationModel.fromJson(message))
        .toList();
  }

  Future<void> createMessage(ConversationModel message) async {
    final response =
        await _client.from('Message').insert(message.toJson()).maybeSingle();

    if (response == null) {
      throw Exception('Failed to create message.');
    }
  }

  Future<void> updateMessage(ConversationModel message) async {
    final response = await _client
        .from('Message')
        .update(message.toJson())
        .eq('message_id', message.conversationId)
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to update message.');
    }
  }

  Future<void> deleteMessage(String messageId) async {
    final response = await _client
        .from('Message')
        .delete()
        .eq('message_id', messageId)
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to delete message.');
    }
  }
}

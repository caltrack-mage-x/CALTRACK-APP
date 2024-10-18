import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/conversation/conversation_model.dart';

class ConversationRepository {
  final SupabaseClient _client;

  ConversationRepository(this._client);

  Future<List<ConversationModel>> getAllConversations() async {
    final response = await _client.from('Conversation').select().maybeSingle();

    if (response == null || (response as List).isEmpty) {
      throw Exception('No conversations found.');
    }

    return (response as List)
        .map((conversation) => ConversationModel.fromJson(conversation))
        .toList();
  }

  Future<void> createConversation(ConversationModel conversation) async {
    final response = await _client
        .from('Conversation')
        .insert(conversation.toJson())
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to create conversation.');
    }
  }

  Future<void> updateConversation(ConversationModel conversation) async {
    final response = await _client
        .from('Conversation')
        .update(conversation.toJson())
        .eq('conversation_id', conversation.conversationId)
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to update conversation.');
    }
  }

  Future<void> deleteConversation(String conversationId) async {
    final response = await _client
        .from('Conversation')
        .delete()
        .eq('conversation_id', conversationId)
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to delete conversation.');
    }
  }
}

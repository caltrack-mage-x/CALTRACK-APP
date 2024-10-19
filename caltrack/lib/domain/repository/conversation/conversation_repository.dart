// Fixed
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/conversation/conversation_model.dart';

class ConversationRepository {
  final SupabaseClient _client;

  ConversationRepository(this._client);

  Future<List<ConversationModel>> getAllConversations() async {
    final response = await _client.from('Conversation').select();

    debugPrint('getAllConversations Response: $response');

    if (response == null || (response as List).isEmpty) {
      debugPrint('No conversations found.');
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
        .single();

    debugPrint('createConversation Response: $response');

    if (response == null) {
      debugPrint('Failed to create conversation.');
      throw Exception('Failed to create conversation.');
    }
  }

  Future<void> updateConversation(ConversationModel conversation) async {
    final response = await _client
        .from('Conversation')
        .update(conversation.toJson())
        .eq('conversation_id', conversation.conversationId)
        .single();

    debugPrint('updateConversation Response: $response');

    if (response == null) {
      debugPrint('Failed to update conversation.');
      throw Exception('Failed to update conversation.');
    }
  }

  Future<void> deleteConversation(String conversationId) async {
    final response = await _client
        .from('Conversation')
        .delete()
        .eq('conversation_id', conversationId)
        .single();

    debugPrint('deleteConversation Response: $response');

    if (response == null) {
      debugPrint('Failed to delete conversation.');
      throw Exception('Failed to delete conversation.');
    }
  }
}

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

    if ((response).isEmpty) {
      debugPrint('No conversations found.');
      throw Exception('No conversations found.');
    }

    return (response)
        .map((conversation) => ConversationModel.fromJson(conversation))
        .toList();
  }

  Future<void> createConversation(ConversationModel conversation) async {
    final response = await _client
        .from('Conversation')
        .insert(conversation.toJson())
        .single();

    debugPrint('createConversation Response: $response');
  }

  Future<void> updateConversation(ConversationModel conversation) async {
    final response = await _client
        .from('Conversation')
        .update(conversation.toJson())
        .eq('conversation_id', conversation.conversationId)
        .single();

    debugPrint('updateConversation Response: $response');
  }

  Future<void> deleteConversation(String conversationId) async {
    final response = await _client
        .from('Conversation')
        .delete()
        .eq('conversation_id', conversationId)
        .single();

    debugPrint('deleteConversation Response: $response');
  }
}

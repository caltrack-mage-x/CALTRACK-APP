import '../repository/conversation_repository.dart';
import '../models/conversation_model.dart';

class ConversationService {
  final ConversationRepository _conversationRepository;

  ConversationService(this._conversationRepository);

  Future<List<ConversationModel>> getAllConversations() async {
    return await _conversationRepository.getAllConversations();
  }

  Future<void> createConversation(ConversationModel conversation) async {
    await _conversationRepository.createConversation(conversation);
  }

  Future<void> updateConversation(ConversationModel conversation) async {
    await _conversationRepository.updateConversation(conversation);
  }

  Future<void> deleteConversation(String conversationId) async {
    await _conversationRepository.deleteConversation(conversationId);
  }
}

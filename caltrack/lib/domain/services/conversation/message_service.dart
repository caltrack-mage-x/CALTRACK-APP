import 'package:caltrack/domain/repository/conversation/message_repository.dart';

import '../../repository/conversation/conversation_repository.dart';
import '../../models/conversation/conversation_model.dart';

class MessageService {
  final MessageRepository _messageRepository;

  MessageService(this._messageRepository);

  // Future<List<MessageModel>> getAllConversations() async {
  //   return await _messageRepository.getAllMessages();
  // }
  //
  // Future<void> createConversation(ConversationModel conversation) async {
  //   await _messageRepository.createConversation(conversation);
  // }
  //
  // Future<void> updateConversation(ConversationModel conversation) async {
  //   await _messageRepository.updateConversation(conversation);
  // }
  //
  // Future<void> deleteConversation(String conversationId) async {
  //   await _messageRepository.deleteConversation(conversationId);
  // }
}

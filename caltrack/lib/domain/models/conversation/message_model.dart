class ConversationModel {
  final String conversationId;
  final String userId;
  final String topicId;
  final DateTime startedAt;
  final DateTime updatedAt;

  ConversationModel({
    required this.conversationId,
    required this.userId,
    required this.topicId,
    required this.startedAt,
    required this.updatedAt,
  });

  factory ConversationModel.fromJson(Map<String, dynamic> json) {
    return ConversationModel(
      conversationId: json['conversation_id'],
      userId: json['user_id'],
      topicId: json['topic_id'],
      startedAt: DateTime.parse(json['started_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'conversation_id': conversationId,
      'user_id': userId,
      'topic_id': topicId,
      'started_at': startedAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}

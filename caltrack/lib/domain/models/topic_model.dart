class TopicModel {
  final String topicId;
  final String name;
  final String? description;

  TopicModel({
    required this.topicId,
    required this.name,
    this.description,
  });

  factory TopicModel.fromJson(Map<String, dynamic> json) {
    return TopicModel(
      topicId: json['topic_id'],
      name: json['name'],
      description: json['description'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'topic_id': topicId,
      'name': name,
      'description': description,
    };
  }
}

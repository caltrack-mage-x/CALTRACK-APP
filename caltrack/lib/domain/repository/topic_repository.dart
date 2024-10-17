import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/topic_model.dart';

class TopicRepository {
  final SupabaseClient _client;

  TopicRepository(this._client);

  Future<List<TopicModel>> getAllTopics() async {
    final response = await _client.from('Topic').select().maybeSingle();

    if (response == null || (response as List).isEmpty) {
      throw Exception('No topics found.');
    }

    return (response as List)
        .map((topic) => TopicModel.fromJson(topic))
        .toList();
  }

  Future<void> createTopic(TopicModel topic) async {
    final response =
        await _client.from('Topic').insert(topic.toJson()).maybeSingle();

    if (response == null) {
      throw Exception('Failed to create topic.');
    }
  }

  Future<void> updateTopic(TopicModel topic) async {
    final response = await _client
        .from('Topic')
        .update(topic.toJson())
        .eq('topic_id', topic.topicId)
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to update topic.');
    }
  }

  Future<void> deleteTopic(String topicId) async {
    final response = await _client
        .from('Topic')
        .delete()
        .eq('topic_id', topicId)
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to delete topic.');
    }
  }
}

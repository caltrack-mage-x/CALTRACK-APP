// Fixed
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/conversation/topic_model.dart';

class TopicRepository {
  final SupabaseClient _client;

  TopicRepository(this._client);

  Future<List<TopicModel>> getAllTopics() async {
    final response = await _client.from('Topic').select();

    debugPrint('getAllTopics Response: $response');

    if (response == null || (response as List).isEmpty) {
      debugPrint('No topics found.');
      throw Exception('No topics found.');
    }

    return (response as List)
        .map((topic) => TopicModel.fromJson(topic))
        .toList();
  }

  Future<void> createTopic(TopicModel topic) async {
    final response =
    await _client.from('Topic').insert(topic.toJson()).single();

    debugPrint('createTopic Response: $response');

    if (response == null) {
      debugPrint('Failed to create topic.');
      throw Exception('Failed to create topic.');
    }
  }

  Future<void> updateTopic(TopicModel topic) async {
    final response = await _client
        .from('Topic')
        .update(topic.toJson())
        .eq('topic_id', topic.topicId)
        .single();

    debugPrint('updateTopic Response: $response');

    if (response == null) {
      debugPrint('Failed to update topic.');
      throw Exception('Failed to update topic.');
    }
  }

  Future<void> deleteTopic(String topicId) async {
    final response = await _client
        .from('Topic')
        .delete()
        .eq('topic_id', topicId)
        .single();

    debugPrint('deleteTopic Response: $response');

    if (response == null) {
      debugPrint('Failed to delete topic.');
      throw Exception('Failed to delete topic.');
    }
  }
}

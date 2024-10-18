import '../../repository/conversation/topic_repository.dart';
import '../../models/conversation/topic_model.dart';

class TopicService {
  final TopicRepository _topicRepository;

  TopicService(this._topicRepository);

  Future<List<TopicModel>> getAllTopics() async {
    return await _topicRepository.getAllTopics();
  }

  Future<void> createTopic(TopicModel topic) async {
    await _topicRepository.createTopic(topic);
  }

  Future<void> updateTopic(TopicModel topic) async {
    await _topicRepository.updateTopic(topic);
  }

  Future<void> deleteTopic(String topicId) async {
    await _topicRepository.deleteTopic(topicId);
  }
}

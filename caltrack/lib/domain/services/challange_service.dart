import '../repository/challange_repository.dart';
import '../models/challange_model.dart';

class ChallengeService {
  final ChallengeRepository _challengeRepository;

  ChallengeService(this._challengeRepository);

  Future<List<ChallengeModel>> getAllChallenges() async {
    return await _challengeRepository.getAllChallenges();
  }

  Future<void> createChallenge(ChallengeModel challenge) async {
    await _challengeRepository.createChallenge(challenge);
  }

  Future<void> updateChallenge(ChallengeModel challenge) async {
    await _challengeRepository.updateChallenge(challenge);
  }

  Future<void> deleteChallenge(String challengeId) async {
    await _challengeRepository.deleteChallenge(challengeId);
  }
}

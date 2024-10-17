import '../repository/userchallange_repository.dart';
import '../models/userchallange_model.dart';

class UserChallengeService {
  final UserChallengeRepository _userChallengeRepository;

  UserChallengeService(this._userChallengeRepository);

  Future<List<UserChallengeModel>> getAllUserChallenges() async {
    return await _userChallengeRepository.getAllUserChallenges();
  }

  Future<void> createUserChallenge(UserChallengeModel userChallenge) async {
    await _userChallengeRepository.createUserChallenge(userChallenge);
  }

  Future<void> updateUserChallenge(UserChallengeModel userChallenge) async {
    await _userChallengeRepository.updateUserChallenge(userChallenge);
  }

  Future<void> deleteUserChallenge(String userChallengeId) async {
    await _userChallengeRepository.deleteUserChallenge(userChallengeId);
  }
}

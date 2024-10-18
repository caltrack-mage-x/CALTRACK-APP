import 'package:caltrack/domain/models/gamification/view_userchallange_model.dart';
import 'package:caltrack/domain/repository/gamification/view_userchallange_repository.dart';

class UserChallengesService {
  final UserChallengesRepository _userChallengesRepository;

  UserChallengesService(this._userChallengesRepository);

  Future<List<UserChallengesModel>> fetchAllUserChallenges() async {
    try {
      return await _userChallengesRepository.getAllUserChallenges();
    } catch (e) {
      throw Exception('Failed to load user challenges: $e');
    }
  }
}

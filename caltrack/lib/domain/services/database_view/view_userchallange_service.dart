import 'package:caltrack/domain/models/database_view/view_userchallange_model.dart';
import 'package:caltrack/domain/repository/database_view/view_userchallange_repository.dart';

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

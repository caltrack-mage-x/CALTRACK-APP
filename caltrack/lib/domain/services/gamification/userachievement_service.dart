import '../../repository/gamification/userachievement_repository.dart';
import '../../models/gamification/userachievement_model.dart';

class UserAchievementService {
  final UserAchievementRepository _userAchievementRepository;

  UserAchievementService(this._userAchievementRepository);

  Future<List<UserAchievementModel>> getAllUserAchievements() async {
    return await _userAchievementRepository.getAllUserAchievements();
  }

  Future<void> createUserAchievement(
      UserAchievementModel userAchievement) async {
    await _userAchievementRepository.createUserAchievement(userAchievement);
  }

  Future<void> updateUserAchievement(
      UserAchievementModel userAchievement) async {
    await _userAchievementRepository.updateUserAchievement(userAchievement);
  }

  Future<void> deleteUserAchievement(String userAchievementId) async {
    await _userAchievementRepository.deleteUserAchievement(userAchievementId);
  }
}

import '../repository/achievement_repository.dart';
import '../models/achievement_model.dart';

class AchievementService {
  final AchievementRepository _achievementRepository;

  AchievementService(this._achievementRepository);

  Future<List<AchievementModel>> getAllAchievements() async {
    return await _achievementRepository.getAllAchievements();
  }

  Future<void> createAchievement(AchievementModel achievement) async {
    await _achievementRepository.createAchievement(achievement);
  }

  Future<void> updateAchievement(AchievementModel achievement) async {
    await _achievementRepository.updateAchievement(achievement);
  }

  Future<void> deleteAchievement(String achievementId) async {
    await _achievementRepository.deleteAchievement(achievementId);
  }
}

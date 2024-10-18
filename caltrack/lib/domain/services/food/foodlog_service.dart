import '../../repository/food/foodlog_repository.dart';
import '../../models/food/foodlog_model.dart';

class FoodLogService {
  final FoodLogRepository _foodLogRepository;

  FoodLogService(this._foodLogRepository);

  Future<List<FoodLogModel>> getAllFoodLogs() async {
    return await _foodLogRepository.getAllFoodLogs();
  }

  Future<void> createFoodLog(FoodLogModel foodLog) async {
    await _foodLogRepository.createFoodLog(foodLog);
  }

  Future<void> updateFoodLog(FoodLogModel foodLog) async {
    await _foodLogRepository.updateFoodLog(foodLog);
  }

  Future<void> deleteFoodLog(String logId) async {
    await _foodLogRepository.deleteFoodLog(logId);
  }
}

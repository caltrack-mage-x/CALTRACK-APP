import '../repository/food_repository.dart';
import '../models/food_model.dart';

class FoodService {
  final FoodRepository _foodRepository;

  FoodService(this._foodRepository);

  Future<List<FoodModel>> getAllFoods() async {
    return await _foodRepository.getAllFoods();
  }

  Future<void> createFood(FoodModel food) async {
    await _foodRepository.createFood(food);
  }

  Future<void> updateFood(FoodModel food) async {
    await _foodRepository.updateFood(food);
  }

  Future<void> deleteFood(String foodId) async {
    await _foodRepository.deleteFood(foodId);
  }
}

// Fixed
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/food/food_model.dart';
import 'package:flutter/foundation.dart';

class FoodRepository {
  final SupabaseClient _client;

  FoodRepository(this._client);

  Future<List<FoodModel>> getAllFoods() async {
    final response = await _client.from('Food').select();

    debugPrint('getAllFoods Response: $response');

    if (response == null || (response as List).isEmpty) {
      debugPrint('No foods found.');
      throw Exception('No foods found.');
    }

    return (response as List)
        .map((food) => FoodModel.fromJson(food))
        .toList();
  }

  Future<void> createFood(FoodModel food) async {
    final response = await _client.from('Food').insert(food.toJson());

    if (response == null) {
      debugPrint('Failed to create food.');
      throw Exception('Failed to create food.');
    }
  }

  Future<void> updateFood(FoodModel food) async {
    final response = await _client
        .from('Food')
        .update(food.toJson())
        .eq('food_id', food.foodId);

    if (response == null) {
      debugPrint('Failed to update food.');
      throw Exception('Failed to update food.');
    }
  }

  Future<void> deleteFood(String foodId) async {
    final response = await _client
        .from('Food')
        .delete()
        .eq('food_id', foodId);

    if (response == null) {
      debugPrint('Failed to delete food.');
      throw Exception('Failed to delete food.');
    }
  }
}

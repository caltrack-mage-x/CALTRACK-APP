import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/food/food_model.dart';

class FoodRepository {
  final SupabaseClient _client;

  FoodRepository(this._client);

  Future<List<FoodModel>> getAllFoods() async {
    final response = await _client.from('Food').select().maybeSingle();

    if (response == null || (response as List).isEmpty) {
      throw Exception('No foods found.');
    }

    return (response as List).map((food) => FoodModel.fromJson(food)).toList();
  }

  Future<void> createFood(FoodModel food) async {
    final response =
        await _client.from('Food').insert(food.toJson()).maybeSingle();

    if (response == null) {
      throw Exception('Failed to create food.');
    }
  }

  Future<void> updateFood(FoodModel food) async {
    final response = await _client
        .from('Food')
        .update(food.toJson())
        .eq('food_id', food.foodId)
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to update food.');
    }
  }

  Future<void> deleteFood(String foodId) async {
    final response =
        await _client.from('Food').delete().eq('food_id', foodId).maybeSingle();

    if (response == null) {
      throw Exception('Failed to delete food.');
    }
  }
}

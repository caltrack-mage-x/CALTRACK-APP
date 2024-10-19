// Fixed
import 'package:caltrack/domain/models/food/view_foodlogdetails_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';

class FoodLogDetailsRepository {
  final SupabaseClient _client;

  FoodLogDetailsRepository(this._client);

  Future<List<FoodLogDetailsModel>> getAllFoodLogs() async {
    final response = await _client.from('food_log_details').select();

    debugPrint('getAllFoodLogs Response: $response');

    if (response == null || (response as List).isEmpty) {
      debugPrint('No food logs found.');
      throw Exception('No food logs found.');
    }

    return (response as List)
        .map((foodLog) => FoodLogDetailsModel.fromJson(foodLog))
        .toList();
  }
}

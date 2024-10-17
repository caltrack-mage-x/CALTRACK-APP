import 'package:caltrack/domain/models/database_view/view_foodlogdetails_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FoodLogDetailsRepository {
  final SupabaseClient _client;

  FoodLogDetailsRepository(this._client);

  Future<List<FoodLogDetailsModel>> getAllFoodLogs() async {
    final response = await _client.from('food_log_details').select();

    if (response == null || (response as List).isEmpty) {
      throw Exception('No food logs found.');
    }

    return (response as List)
        .map((foodLog) => FoodLogDetailsModel.fromJson(foodLog))
        .toList();
  }
}

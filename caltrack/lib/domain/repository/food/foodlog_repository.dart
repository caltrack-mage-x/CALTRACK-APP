// Fixed
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/food/foodlog_model.dart';
import 'package:flutter/foundation.dart';

class FoodLogRepository {
  final SupabaseClient _client;

  FoodLogRepository(this._client);

  Future<List<FoodLogModel>> getAllFoodLogs() async {
    final response = await _client.from('FoodLog').select();

    debugPrint('getAllFoodLogs Response: $response');

    if ((response).isEmpty) {
      debugPrint('No food logs found.');
      throw Exception('No food logs found.');
    }

    return (response)
        .map((log) => FoodLogModel.fromJson(log))
        .toList();
  }

  Future<void> createFoodLog(FoodLogModel log) async {
    final response = await _client.from('FoodLog').insert(log.toJson());

    if (response == null) {
      debugPrint('Failed to create food log.');
      throw Exception('Failed to create food log.');
    }
  }

  Future<void> updateFoodLog(FoodLogModel log) async {
    final response = await _client
        .from('FoodLog')
        .update(log.toJson())
        .eq('log_id', log.logId);

    if (response == null) {
      debugPrint('Failed to update food log.');
      throw Exception('Failed to update food log.');
    }
  }

  Future<void> deleteFoodLog(String logId) async {
    final response = await _client
        .from('FoodLog')
        .delete()
        .eq('log_id', logId);

    if (response == null) {
      debugPrint('Failed to delete food log.');
      throw Exception('Failed to delete food log.');
    }
  }
}

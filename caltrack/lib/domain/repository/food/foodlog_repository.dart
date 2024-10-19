import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/food/foodlog_model.dart';

class FoodLogRepository {
  final SupabaseClient _client;

  FoodLogRepository(this._client);

  Future<List<FoodLogModel>> getAllFoodLogs() async {
    final response = await _client.from('FoodLog').select().maybeSingle();

    if (response == null || (response as List).isEmpty) {
      throw Exception('No food logs found.');
    }

    return (response as List).map((log) => FoodLogModel.fromJson(log)).toList();
  }

  Future<void> createFoodLog(FoodLogModel log) async {
    final response =
        await _client.from('FoodLog').insert(log.toJson()).maybeSingle();

    if (response == null) {
      throw Exception('Failed to create food log.');
    }
  }

  Future<void> updateFoodLog(FoodLogModel log) async {
    final response = await _client
        .from('FoodLog')
        .update(log.toJson())
        .eq('log_id', log.logId)
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to update food log.');
    }
  }

  Future<void> deleteFoodLog(String logId) async {
    final response = await _client
        .from('FoodLog')
        .delete()
        .eq('log_id', logId)
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to delete food log.');
    }
  }
}

// Fixed
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/exercise/exerciselog_model.dart';

class ExerciseLogRepository {
  final SupabaseClient _client;

  ExerciseLogRepository(this._client);

  Future<List<ExerciseLogModel>> getAllExerciseLogs() async {
    final response = await _client.from('ExerciseLog').select();

    debugPrint('getAllExerciseLogs Response: $response');

    if (response == null || (response as List).isEmpty) {
      debugPrint('No exercise logs found.');
      throw Exception('No exercise logs found.');
    }

    return (response as List)
        .map((log) => ExerciseLogModel.fromJson(log))
        .toList();
  }

  Future<void> createExerciseLog(ExerciseLogModel log) async {
    final response =
    await _client.from('ExerciseLog').insert(log.toJson()).single();

    debugPrint('createExerciseLog Response: $response');

    if (response == null) {
      debugPrint('Failed to create exercise log.');
      throw Exception('Failed to create exercise log.');
    }
  }

  Future<void> updateExerciseLog(ExerciseLogModel log) async {
    final response = await _client
        .from('ExerciseLog')
        .update(log.toJson())
        .eq('log_id', log.logId)
        .single();

    debugPrint('updateExerciseLog Response: $response');

    if (response == null) {
      debugPrint('Failed to update exercise log.');
      throw Exception('Failed to update exercise log.');
    }
  }

  Future<void> deleteExerciseLog(String logId) async {
    final response = await _client
        .from('ExerciseLog')
        .delete()
        .eq('log_id', logId)
        .single();

    debugPrint('deleteExerciseLog Response: $response');

    if (response == null) {
      debugPrint('Failed to delete exercise log.');
      throw Exception('Failed to delete exercise log.');
    }
  }
}
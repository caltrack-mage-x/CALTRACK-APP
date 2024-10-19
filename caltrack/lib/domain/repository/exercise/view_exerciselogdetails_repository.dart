// Fixed
import 'package:caltrack/domain/models/exercise/view_exerciselogdetails_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/foundation.dart';

class ExerciseLogDetailsRepository {
  final SupabaseClient _client;

  ExerciseLogDetailsRepository(this._client);

  Future<List<ExerciseLogDetailsModel>> getAllExerciseLogs() async {
    final response = await _client.from('exercise_log_details').select();

    debugPrint('getAllExerciseLogs Response: $response');

    if (response == null || (response as List).isEmpty) {
      debugPrint('No exercise logs found.');
      throw Exception('No exercise logs found.');
    }

    return (response as List)
        .map((exerciseLog) => ExerciseLogDetailsModel.fromJson(exerciseLog))
        .toList();
  }
}

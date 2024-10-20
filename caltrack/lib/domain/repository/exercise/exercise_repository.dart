// Fixed
import 'package:flutter/cupertino.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/exercise/exercise_model.dart';

class ExerciseRepository {
  final SupabaseClient _client;

  ExerciseRepository(this._client);

  Future<List<ExerciseModel>> getAllExercises() async {
    final response = await _client.from('Exercise').select();

    debugPrint('getAllExercises Response: $response');

    if ((response).isEmpty) {
      debugPrint('No exercises found.');
      throw Exception('No exercises found.');
    }

    return (response)
        .map((exercise) => ExerciseModel.fromJson(exercise))
        .toList();
  }

  Future<void> createExercise(ExerciseModel exercise) async {
    final response =
    await _client.from('Exercise').insert(exercise.toJson()).single();

    debugPrint('createExercise Response: $response');
  }

  Future<void> updateExercise(ExerciseModel exercise) async {
    final response = await _client
        .from('Exercise')
        .update(exercise.toJson())
        .eq('exercise_id', exercise.exerciseId)
        .single();

    debugPrint('updateExercise Response: $response');
  }

  Future<void> deleteExercise(String exerciseId) async {
    final response = await _client
        .from('Exercise')
        .delete()
        .eq('exercise_id', exerciseId)
        .single();

    debugPrint('deleteExercise Response: $response');
  }
}

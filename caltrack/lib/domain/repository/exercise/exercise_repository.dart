import 'package:supabase_flutter/supabase_flutter.dart';
import '../../models/exercise/exercise_model.dart';

class ExerciseRepository {
  final SupabaseClient _client;

  ExerciseRepository(this._client);

  Future<List<ExerciseModel>> getAllExercises() async {
    final response = await _client.from('Exercise').select().maybeSingle();

    if (response == null || (response as List).isEmpty) {
      throw Exception('No exercises found.');
    }

    return (response as List)
        .map((exercise) => ExerciseModel.fromJson(exercise))
        .toList();
  }

  Future<void> createExercise(ExerciseModel exercise) async {
    final response =
        await _client.from('Exercise').insert(exercise.toJson()).maybeSingle();

    if (response == null) {
      throw Exception('Failed to create exercise.');
    }
  }

  Future<void> updateExercise(ExerciseModel exercise) async {
    final response = await _client
        .from('Exercise')
        .update(exercise.toJson())
        .eq('exercise_id', exercise.exerciseId)
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to update exercise.');
    }
  }

  Future<void> deleteExercise(String exerciseId) async {
    final response = await _client
        .from('Exercise')
        .delete()
        .eq('exercise_id', exerciseId)
        .maybeSingle();

    if (response == null) {
      throw Exception('Failed to delete exercise.');
    }
  }
}

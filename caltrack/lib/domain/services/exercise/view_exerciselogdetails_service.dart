import 'package:caltrack/domain/models/exercise/view_exerciselogdetails_model.dart';
import 'package:caltrack/domain/repository/exercise/view_exerciselogdetails_repository.dart';

class ExerciseLogDetailsService {
  final ExerciseLogDetailsRepository _exerciseLogDetailsRepository;

  ExerciseLogDetailsService(this._exerciseLogDetailsRepository);

  Future<List<ExerciseLogDetailsModel>> fetchAllExerciseLogs() async {
    try {
      return await _exerciseLogDetailsRepository.getAllExerciseLogs();
    } catch (e) {
      throw Exception('Failed to load exercise logs: $e');
    }
  }
}

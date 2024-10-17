import '../repository/exerciselog_repository.dart';
import '../models/exerciselog_model.dart';

class ExerciseLogService {
  final ExerciseLogRepository _exerciseLogRepository;

  ExerciseLogService(this._exerciseLogRepository);

  Future<List<ExerciseLogModel>> getAllExerciseLogs() async {
    return await _exerciseLogRepository.getAllExerciseLogs();
  }

  Future<void> createExerciseLog(ExerciseLogModel exerciseLog) async {
    await _exerciseLogRepository.createExerciseLog(exerciseLog);
  }

  Future<void> updateExerciseLog(ExerciseLogModel exerciseLog) async {
    await _exerciseLogRepository.updateExerciseLog(exerciseLog);
  }

  Future<void> deleteExerciseLog(String logId) async {
    await _exerciseLogRepository.deleteExerciseLog(logId);
  }
}

class ExerciseModel {
  final String exerciseId;
  final String name;
  final int caloriesBurnedPerHour;

  ExerciseModel({
    required this.exerciseId,
    required this.name,
    required this.caloriesBurnedPerHour,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      exerciseId: json['exercise_id'],
      name: json['name'],
      caloriesBurnedPerHour: json['calories_burned_per_hour'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exercise_id': exerciseId,
      'name': name,
      'calories_burned_per_hour': caloriesBurnedPerHour,
    };
  }
}
